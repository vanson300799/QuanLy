using AutoMapper;
using Common;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web.Helpers;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;
using WebModels.Constants;

namespace WEB.Areas.Admin.Controllers
{
    public class InvoiceController : Controller
    {
        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        // GET: Admin/Invoice
        public ActionResult Index()
        {
            var datekey = db.NoteBookKeys.Select(x => x.DateTimeKey).FirstOrDefault();
            ViewBag.datekey = datekey;
            return View();
        }
        public ActionResult Edit(int id)
        {
            var notbookey = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            ViewBag.notbookDate = notbookey.DateTimeKey.Value;
            var model = db.Set<Invoice>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            var viewModel = GetInvoiceViewModel(model, id);
            viewModel.Date = DateTime.Now;
            ViewBag.cBillID = model.InvoiceCode;
            viewModel.CurrentInvoiceCode = model.InvoiceCode;
            return View("Edit", viewModel);
        }

        private InvoiceViewModel GetInvoiceViewModel(Invoice model, int id)
        {
            var config = new MapperConfiguration(cfg => cfg.CreateMap<Invoice, InvoiceViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<InvoiceViewModel>(model);
            viewModel.InvoiceDetails = db.InvoiceDetails.Where(x => x.ParrentID == model.ID && x.Invoice.IsActive).AsNoTracking().ToList();

            var station = db.Stations.Where(x => x.ID == viewModel.StationID).FirstOrDefault();
            if (station != null)
            {
                viewModel.StationName = station.StationName;
            }
            viewModel.DateString = viewModel.Date.ToString("dd/MM/yyyy HH:mm");
            return viewModel;
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(InvoiceViewModel model)
        {
            var invoiceObj = db.Invoices.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
            var oldViewModel = GetInvoiceViewModel(invoiceObj, model.ID);
            if (!string.IsNullOrEmpty(model.DateString))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.Date = DateTime.ParseExact(model.DateString, format, provider);
            }
            var notbookDate = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            if (model.Date < notbookDate.DateTimeKey.Value)
            {
                return Json(new { message = "Ngày khóa sổ nằm trong phạm vi tính toán! Vui lòng lựa chọn lại" }, JsonRequestBehavior.AllowGet);
            }
            if (model.CustomerID == null)
            {
                return Json(new { ErrorMessage = "Khách hàng không được để trống" }, JsonRequestBehavior.AllowGet);
            }
            var currentUser = UserInfoHelper.GetUserData();

            if (ModelState.IsValid)
            {
                var temp = (from p in db.Set<Invoice>().AsNoTracking()
                            where (p.InvoiceCode.Equals(model.InvoiceCode, StringComparison.OrdinalIgnoreCase) && p.IsActive && p.InvoiceCode != model.CurrentInvoiceCode)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    return Json(new { ErrorMessage = WebResources.InvoiceCodeExists }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    if (model.InvoiceDetails == null)
                    {
                        return Json(new { ErrorMessage = "Chi tiết đơn hàng không được để trống" }, JsonRequestBehavior.AllowGet);
                    }

                    try
                    {
                        using (DbContextTransaction transaction = db.Database.BeginTransaction())
                        {
                            try
                            {
                                List<InvoiceDetail> listedit = new List<InvoiceDetail>();
                                List<InvoiceDetail> listadd = new List<InvoiceDetail>();
                                List<InvoiceDetail> listdelete = new List<InvoiceDetail>();

                                var modelDetail = model.InvoiceDetails;
                                int? parentIDmodel = db.InvoiceDetails.Where(x => x.ParrentID == model.ID && x.IsActive == true && x.Invoice.IsActive).Select(x => x.ParrentID).FirstOrDefault();
                                var modelDB = db.InvoiceDetails.Where(x => x.IsActive == true && x.ParrentID == parentIDmodel && x.Invoice.IsActive);
                                var validmodelDB = modelDB.Count();
                                decimal totalSaleAmount = 0;
                                decimal totalSupplierDiscount = 0;
                                decimal totalFreightCharge = 0;
                                decimal totalMoney = 0;
                                decimal totalCustomerPayment = 0;
                                if (parentIDmodel != 0 && validmodelDB != 0)
                                {
                                    totalSaleAmount = db.InvoiceDetails.Where(x => x.IsActive == true && x.Invoice.IsActive && x.ParrentID == parentIDmodel).Sum(a => a.SaleAmount);
                                    totalSupplierDiscount = db.InvoiceDetails.Where(x => x.IsActive == true && x.Invoice.IsActive && x.ParrentID == parentIDmodel).Sum(a => a.SupplierDiscount);
                                    totalFreightCharge = db.InvoiceDetails.Where(x => x.IsActive == true && x.Invoice.IsActive && x.ParrentID == parentIDmodel).Sum(a => a.FreightCharge);
                                    totalMoney = db.InvoiceDetails.Where(x => x.IsActive == true && x.Invoice.IsActive && x.ParrentID == parentIDmodel).Sum(a => a.Money);
                                    totalCustomerPayment = db.InvoiceDetails.Where(x => x.IsActive == true && x.Invoice.IsActive && x.ParrentID == parentIDmodel).Sum(a => a.CustomerPayment);

                                    if (modelDetail != null)
                                    {
                                        foreach (var item in modelDetail)
                                        {
                                            var InvoiceDetails = new InvoiceDetail
                                            {
                                                ID = item.ID,
                                                ParrentID = model.ID,
                                                StationID = model.StationID.HasValue ? model.StationID.Value : 0,
                                                ProductID = item.ProductID,
                                                SaleAmount = item.SaleAmount,
                                                CostPrice = item.CostPrice,
                                                SalePrice = item.SalePrice,
                                                ListPrice = item.ListPrice,
                                                SupplierDiscount = item.SupplierDiscount,
                                                FreightCharge = item.FreightCharge,
                                                InvoiceType = item.InvoiceType,
                                                Money = item.Money,
                                                CustomerPayment = item.CustomerPayment,
                                                Date = model.Date,
                                                CustomerID = model.CustomerID ?? default(int),
                                                IsActive = true,
                                                ModifiedAt = DateTime.Now,
                                                ModifiedBy = currentUser.UserId,
                                            };
                                            if (item.ID != 0)
                                            {
                                                listedit.Add(InvoiceDetails);
                                            }
                                            else
                                            {
                                                listadd.Add(InvoiceDetails);
                                            }
                                        }
                                    }
                                    if (listedit != null)
                                    {
                                        foreach (var item in listedit)
                                        {
                                            var currentSaleAmount = db.InvoiceDetails.Where(x => x.ID == item.ID && x.Invoice.IsActive).Select(x => x.SaleAmount).FirstOrDefault();
                                            var currentSupplierDiscount = db.InvoiceDetails.Where(x => x.ID == item.ID && x.Invoice.IsActive).Select(x => x.SupplierDiscount).FirstOrDefault();
                                            var currentFreightCharge = db.InvoiceDetails.Where(x => x.ID == item.ID && x.Invoice.IsActive).Select(x => x.FreightCharge).FirstOrDefault();
                                            var currentMoney = db.InvoiceDetails.Where(x => x.ID == item.ID && x.Invoice.IsActive).Select(x => x.Money).FirstOrDefault();
                                            var currentCustomerPayment = db.InvoiceDetails.Where(x => x.ID == item.ID && x.Invoice.IsActive).Select(x => x.CustomerPayment).FirstOrDefault();
                                            totalSaleAmount += (item.SaleAmount - currentSaleAmount);
                                            totalSupplierDiscount += (item.SupplierDiscount - currentSupplierDiscount);
                                            totalFreightCharge += (item.FreightCharge - currentFreightCharge);
                                            totalCustomerPayment += (item.CustomerPayment - currentCustomerPayment);
                                            totalMoney += (item.Money - currentMoney);
                                            db.InvoiceDetails.Attach(item);
                                            db.Entry(item).Property(a => a.ID).IsModified = false;
                                            db.Entry(item).Property(a => a.ParrentID).IsModified = true;
                                            db.Entry(item).Property(a => a.StationID).IsModified = true;
                                            db.Entry(item).Property(a => a.ProductID).IsModified = true;
                                            db.Entry(item).Property(a => a.SaleAmount).IsModified = true;
                                            db.Entry(item).Property(a => a.CostPrice).IsModified = true;
                                            db.Entry(item).Property(a => a.SalePrice).IsModified = true;
                                            db.Entry(item).Property(a => a.ListPrice).IsModified = true;
                                            db.Entry(item).Property(a => a.SupplierDiscount).IsModified = true;
                                            db.Entry(item).Property(a => a.FreightCharge).IsModified = true;
                                            db.Entry(item).Property(a => a.InvoiceType).IsModified = true;
                                            db.Entry(item).Property(a => a.CustomerPayment).IsModified = true;
                                            db.Entry(item).Property(a => a.Money).IsModified = true;
                                            db.Entry(item).Property(a => a.Date).IsModified = true;
                                            db.Entry(item).Property(a => a.CustomerID).IsModified = true;
                                            db.SaveChanges();
                                        }
                                    }
                                    foreach (var itemDB in modelDB)
                                    {
                                        bool checkDelete = true;
                                        foreach (var item in listedit)
                                        {
                                            if (itemDB.ID == item.ID)
                                            {
                                                checkDelete = false;
                                                break;
                                            }
                                        }
                                        if (checkDelete == true)
                                        {
                                            listdelete.Add(itemDB);
                                        }
                                    }
                                    if (listdelete != null)
                                    {
                                        foreach (var item in listdelete)
                                        {
                                            totalSaleAmount -= item.SaleAmount;
                                            totalSupplierDiscount -= item.SupplierDiscount;
                                            totalFreightCharge -= item.FreightCharge;
                                            totalCustomerPayment -= item.CustomerPayment;
                                            totalMoney -= item.Money;
                                            var remove = db.InvoiceDetails.FirstOrDefault(x => x.ID == item.ID && x.Invoice.IsActive);
                                            remove.IsActive = false;
                                        }
                                    }
                                    db.SaveChanges();
                                    if (listadd != null)
                                    {
                                        foreach (var item in listadd)
                                        {
                                            totalSaleAmount += item.SaleAmount;
                                            totalSupplierDiscount += item.SupplierDiscount;
                                            totalFreightCharge += item.FreightCharge;
                                            totalCustomerPayment += item.CustomerPayment;
                                            totalMoney += item.Money;
                                            AddInvoiceDetail(item);
                                        }
                                    }

                                    Invoice invoice = new Invoice
                                    {
                                        ID = model.ID,
                                        StationID = model.StationID,
                                        InvoiceCode = model.InvoiceCode,
                                        CustomerID = model.CustomerID ?? default(int),
                                        Note = model.Note,
                                        Vehicle = model.Vehicle?.Trim(),
                                        TotalDiscount = totalSupplierDiscount,
                                        TotalFreightCharge = totalFreightCharge,
                                        TotalMoney = totalMoney,
                                        TotalQuantity = totalSaleAmount,
                                        CustomerPayment = totalCustomerPayment,
                                        Date = model.Date,
                                    };

                                    db.Invoices.Attach(invoice);
                                    db.Entry(invoice).Property(a => a.ID).IsModified = false;
                                    db.Entry(invoice).Property(a => a.Date).IsModified = true;
                                    db.Entry(invoice).Property(a => a.InvoiceCode).IsModified = true;
                                    db.Entry(invoice).Property(a => a.CustomerID).IsModified = true;
                                    db.Entry(invoice).Property(a => a.StationID).IsModified = true;
                                    db.Entry(invoice).Property(a => a.Note).IsModified = true;
                                    db.Entry(invoice).Property(a => a.Vehicle).IsModified = true;
                                    db.Entry(invoice).Property(a => a.TotalDiscount).IsModified = true;
                                    db.Entry(invoice).Property(a => a.TotalFreightCharge).IsModified = true;
                                    db.Entry(invoice).Property(a => a.TotalMoney).IsModified = true;
                                    db.Entry(invoice).Property(a => a.TotalQuantity).IsModified = true;
                                    db.Entry(invoice).Property(a => a.CustomerPayment).IsModified = true;
                                    db.SaveChanges();
                                    var oldJson = oldViewModel.ToJson();
                                    var newJson = model.ToJson();
                                    LogSystem log = new LogSystem
                                    {
                                        ActiveType = DataActionTypeConstant.UPDATE_INVOICE_ACTION,
                                        FunctionName = DataFunctionNameConstant.UPDATE_INVOICE_FUNCTION,
                                        DataTable = DataTableConstant.INVOICE,
                                        Information = string.Format("Trước khi thay đổi: {0}<br/><br/> Sau khi thay đổi: {1}", oldJson, newJson)
                                    };

                                    AddLogSystem.AddLog(log);
                                    transaction.Commit();
                                    return View(model);
                                }
                            }
                            catch (Exception ex)
                            {
                                transaction.Rollback();
                            }
                            return View(model);
                        }
                    }
                    catch (Exception ex)
                    {
                        ModelState.AddModelError("", string.Format("Đã xảy ra lỗi, chi tiết lỗi: \n{0}", ex.Message));
                        return View(model);
                    }
                }
            }
            else
            {
                return View(model);
            }

        }
        public ActionResult Add()
        {
            var notbookey = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            ViewBag.notbookDate = notbookey.DateTimeKey.Value;
            var model = new InvoiceViewModel();            
            var currentMaxId = db.Invoices.Where(x => x.IsActive).ToList().Where(z=> int.TryParse(z.InvoiceCode, out int invoiceCode))
                .OrderByDescending(y => int.Parse(y.InvoiceCode)).FirstOrDefault();
            if (currentMaxId != null)
            {
                var currentNumber = int.Parse(currentMaxId.InvoiceCode);
                model.InvoiceCode = string.Format("{0}", (currentNumber + 1).ToString().PadLeft(7, '0'));
            }
            else
            {
                model.InvoiceCode = "0000001";
            }
            model.DateString = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
            model.InvoiceDetails = db.InvoiceDetails.Where(x => x.ParrentID == null && x.Invoice.IsActive);
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID;
            }

            return View(model);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] InvoiceViewModel model)
        {
            var invoiceChangeJson = model.ToJson();
            if (!string.IsNullOrEmpty(model.DateString))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.Date = DateTime.ParseExact(model.DateString, format, provider);
            }

            var notbookDate = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();

            if (model.Date < notbookDate.DateTimeKey.Value.Date)
            {
                return Json(new { message = "Ngày khóa sổ nằm trong phạm vi tính toán! Vui lòng lựa chọn lại" }, JsonRequestBehavior.AllowGet);
            }
            var currentUser = UserInfoHelper.GetUserData();
            if (model.CustomerID == null)
            {
                return Json(new { ErrorMessage = "Khách hàng không được để trống" }, JsonRequestBehavior.AllowGet);
            }
            else
            {
                if (ModelState.IsValid)
                {
                    var temp = (from p in db.Set<Invoice>().AsNoTracking()
                                where (p.InvoiceCode.Equals(model.InvoiceCode, StringComparison.OrdinalIgnoreCase) && p.IsActive)
                                select p).FirstOrDefault();

                    if (temp != null)
                    {
                        return Json(new { ErrorMessage = WebResources.InvoiceCodeExists }, JsonRequestBehavior.AllowGet);
                    }
                    else
                    {
                        if (model.InvoiceDetails == null)
                        {
                            return Json(new { ErrorMessage = "Chi tiết đơn hàng không được để trống" }, JsonRequestBehavior.AllowGet);
                        }

                        try
                        {
                            using (DbContextTransaction transaction = db.Database.BeginTransaction())
                            {
                                List<InvoiceDetail> listadd = new List<InvoiceDetail>();

                                var modelDetail = model.InvoiceDetails;
                                decimal totalSaleAmount = 0;
                                decimal totalSupplierDiscount = 0;
                                decimal totalFreightCharge = 0;
                                decimal totalMoney = 0;
                                decimal totalCustomerPayment = 0;
                                if (modelDetail != null)
                                {
                                    foreach (var item in modelDetail)
                                    {
                                        totalSaleAmount += item.SaleAmount;
                                        totalSupplierDiscount += item.SupplierDiscount;
                                        totalFreightCharge += item.FreightCharge;
                                        totalCustomerPayment += item.CustomerPayment;
                                        totalMoney += item.Money;
                                    };
                                }

                                Invoice invoice = new Invoice
                                {
                                    Date = model.Date,
                                    CreatedAt = DateTime.Now,
                                    StationID = model.StationID,
                                    CustomerID = model.CustomerID ?? default(int),
                                    Note = model.Note,
                                    TotalQuantity = totalSaleAmount,
                                    TotalDiscount = totalSupplierDiscount,
                                    TotalFreightCharge = totalFreightCharge,
                                    TotalMoney = totalMoney,
                                    InvoiceCode = model.InvoiceCode,
                                    CreatedBy = currentUser.UserId,
                                    Vehicle = model.Vehicle?.Trim(),
                                    CustomerPayment = totalCustomerPayment,
                                    IsActive = true,
                                    IsLock = false
                                };

                                db.Invoices.Add(invoice);
                                db.SaveChanges();
                                try
                                {
                                    foreach (var item in modelDetail)
                                    {
                                        var invoiceDetal = new InvoiceDetail
                                        {
                                            ProductID = item.ProductID,
                                            StationID = model.StationID.HasValue ? model.StationID.Value : 0,
                                            Date = invoice.Date,
                                            Money = item.Money,
                                            ParrentID = invoice.ID,
                                            CustomerID = model.CustomerID ?? default(int),
                                            SaleAmount = item.SaleAmount,
                                            InvoiceRevenue = item.InvoiceRevenue,
                                            CostPrice = item.CostPrice,
                                            SalePrice = item.SalePrice,
                                            ListPrice = item.ListPrice,
                                            FreightCharge = item.FreightCharge,
                                            SupplierDiscount = item.SupplierDiscount,
                                            InvoiceType = item.InvoiceType,
                                            CustomerPayment = item.CustomerPayment,
                                            CreatedAt = DateTime.Now,
                                            CreatedBy = currentUser.UserId,
                                            IsActive = true
                                        };
                                        listadd.Add(invoiceDetal);
                                    }

                                    foreach (var item in listadd)
                                    {
                                        AddInvoiceDetail(item);
                                    }

                                    LogSystem log = new LogSystem
                                    {
                                        ActiveType = DataActionTypeConstant.ADD_INVOICE_ACTION,
                                        FunctionName = DataFunctionNameConstant.ADD_INVOICE_FUNCTION,
                                        DataTable = DataTableConstant.INVOICE,
                                        Information = invoiceChangeJson
                                    };

                                    AddLogSystem.AddLog(log);
                                    transaction.Commit();
                                    return View(model);
                                }
                                catch (Exception ex)
                                {
                                    transaction.Rollback();
                                    return Json(new { ErrorMessage = string.Format("Đã xảy ra lỗi, chi tiết lỗi: \n{0}", ex.Message) }, JsonRequestBehavior.AllowGet);
                                }
                            }
                        }
                        catch (Exception ex)
                        {
                            return Json(new { ErrorMessage = string.Format("Đã xảy ra lỗi, chi tiết lỗi: \n{0}", ex.Message) }, JsonRequestBehavior.AllowGet);
                        }
                    }
                }
                else
                {
                    return Json(new { ErrorMessage = string.Empty }, JsonRequestBehavior.AllowGet);
                }
            }


        }

        public ActionResult Invoice_Read([DataSourceRequest] DataSourceRequest request)
        {
            var currentUser = UserInfoHelper.GetUserData();
            var price = from sb in db.Invoices.Where(x => x.IsActive == true && (!currentUser.StationID.HasValue || x.StationID == currentUser.StationID))
                        join sc in db.Stations on sb.StationID equals sc.ID
                        join cum in db.Customers on sb.CustomerID equals cum.ID
                        select new InvoiceIndexViewModel
                        {
                            ID = sb.ID,
                            Date = (DateTime)sb.Date,
                            InvoiceCode = sb.InvoiceCode,
                            CustomerID = sb.CustomerID,
                            CustomerName = cum.CustomerName,
                            StationID = sb.StationID,
                            StationName = sc.StationName,
                            Note = sb.Note,
                            Vehicle = sb.Vehicle,
                            TotalQuantity = sb.TotalQuantity,
                            TotalFreightCharge = sb.TotalFreightCharge,
                            TotalDiscount = sb.TotalDiscount,
                            TotalMoney = sb.TotalMoney,
                            CustomerPayment = sb.CustomerPayment,
                            IsLock = sb.IsLock,
                        };
            return Json(price.OrderByDescending(x => x.Date).ToDataSourceResult(request), JsonRequestBehavior.AllowGet);
        }
        public ActionResult Invoice_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<Invoice> models)
        {
            var invoiceChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.Invoices.FirstOrDefault(x => x.ID == model.ID);
                var listremovedetail = db.InvoiceDetails.Where(x => x.ParrentID == model.ID).ToList();
                foreach (var item in listremovedetail)
                {
                    item.IsActive = false;
                }
                db.SaveChanges();
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_INVOICE_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_INVOICE_FUNCTION,
                DataTable = DataTableConstant.INVOICE,
                Information = invoiceChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.ToDataSourceResult(request));
        }
        public ActionResult InvoiceDetailIndex([DataSourceRequest] DataSourceRequest request, int? id)
        {
            var detail = from bd in db.InvoiceDetails.Where(x => x.IsActive == true && x.ParrentID == id && x.Invoice.IsActive)
                         join pd in db.Products on bd.ProductID equals pd.ID into group3
                         from item3 in group3.DefaultIfEmpty()
                         select new InvoiceDetailViewModel
                         {
                             ID = bd.ID,
                             Date = (DateTime)bd.Date,
                             ProductID = bd.ProductID,
                             ProductName = item3.ProductName,
                             ProductCode = item3.ProductCode,
                             SaleAmount = bd.SaleAmount,
                             CostPrice = bd.CostPrice,
                             SalePrice = bd.SalePrice,
                             ListPrice = bd.ListPrice,
                             SupplierDiscount = bd.SupplierDiscount,
                             FreightCharge = bd.FreightCharge,
                             InvoiceType = bd.InvoiceType,
                             Money = bd.Money,
                             CustomerPayment = bd.CustomerPayment,
                             IsActive = bd.IsActive,
                             CreatedAt = (DateTime)bd.CreatedAt,
                             CreatedBy = bd.CreatedBy,
                         };
            return Json(detail.ToList(), JsonRequestBehavior.AllowGet);
        }
        public ActionResult InvoiceDetailRead([DataSourceRequest] DataSourceRequest request, int? id)
        {
            var detail = from bd in db.InvoiceDetails.Where(x => x.IsActive == true && x.Invoice.IsActive && x.ParrentID == id)
                         join pd in db.Products on bd.ProductID equals pd.ID into group3
                         from item3 in group3.DefaultIfEmpty()
                         select new InvoiceDetailViewModel
                         {
                             ID = bd.ID,
                             Date = (DateTime)bd.Date,
                             ProductID = bd.ProductID,
                             ProductCode = item3.ProductCode,
                             ProductName = item3.ProductName,
                             SaleAmount = bd.SaleAmount,
                             CostPrice = bd.CostPrice,
                             SalePrice = bd.SalePrice,
                             ListPrice = bd.ListPrice,
                             SupplierDiscount = bd.SupplierDiscount,
                             FreightCharge = bd.FreightCharge,
                             InvoiceType = bd.InvoiceType,
                             Money = bd.Money,
                             CustomerPayment = bd.CustomerPayment,
                         };

            return Json(detail.ToList(), JsonRequestBehavior.AllowGet);
        }

        public ActionResult _InvoiceDetail([DataSourceRequest] DataSourceRequest request, int? id)
        {
            var detail = from bd in db.InvoiceDetails.Where(x => x.IsActive == true && x.Invoice.IsActive && x.ParrentID == id)
                         join pd in db.Products on bd.ProductID equals pd.ID into group3
                         from item3 in group3.DefaultIfEmpty()
                         select new InvoiceDetailViewModel
                         {
                             ID = bd.ID,
                             Date = (DateTime)bd.Date,
                             ProductID = bd.ProductID,
                             ProductCode = item3.ProductCode,
                             ProductName = item3.ProductName,
                             SaleAmount = bd.SaleAmount,
                             CostPrice = bd.CostPrice,
                             SalePrice = bd.SalePrice,
                             ListPrice = bd.ListPrice,
                             SupplierDiscount = bd.SupplierDiscount,
                             FreightCharge = bd.FreightCharge,
                             InvoiceType = bd.InvoiceType,
                             Money = bd.Money,
                             CustomerPayment = bd.CustomerPayment
                         };
            ViewBag.parentID = id;
            var temp = detail.ToList();
            return PartialView("_InvoiceDetail", detail);
        }


        public void AddInvoiceDetail(InvoiceDetail model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            InvoiceDetail addModel = new InvoiceDetail
            {
                ParrentID = model.ParrentID,
                ProductID = model.ProductID,
                CostPrice = model.CostPrice,
                SalePrice = model.SalePrice,
                ListPrice = model.ListPrice,
                FreightCharge = model.FreightCharge,
                CustomerID = model.CustomerID,
                SupplierDiscount = model.SupplierDiscount,
                CustomerPayment = model.CustomerPayment,
                InvoiceRevenue = model.InvoiceRevenue,
                InvoiceType = model.InvoiceType,
                Money = model.Money,
                SaleAmount = model.SaleAmount,
                CreatedAt = DateTime.Now,
                CreatedBy = currentUser.UserId,
                Date = model.Date,
                IsActive = true,
                StationID = (currentUser.StationID.HasValue ? currentUser.StationID : model.StationID) ?? default(int),
                ModifiedAt = DateTime.Now,
                ModifiedBy = currentUser.UserId,
            };

            var helper = new RecalculateHelper();
            var costPriceResult = helper.GetCostPrice(db, model.ProductID, model.StationID, addModel);

            db.InvoiceDetails.Add(addModel);
            db.SaveChanges();

            db.InvoiceDetailReports.RemoveMany(db.InvoiceDetailReports.Where(x => x.InvoiceDetailId == addModel.ID));

            foreach (var item in costPriceResult)
            {
                var invoiceDetailReport = new InvoiceDetailReport()
                {
                    ParrentID = model.ParrentID,
                    ProductID = model.ProductID,
                    SalePrice = model.SalePrice,
                    ListPrice = model.ListPrice,
                    FreightCharge = model.FreightCharge,
                    CustomerID = model.CustomerID,
                    SupplierDiscount = model.SupplierDiscount,
                    CustomerPayment = model.CustomerPayment,
                    InvoiceRevenue = model.InvoiceRevenue,
                    InvoiceType = model.InvoiceType,
                    Money = item.QuantityTaken * model.SalePrice,
                    StationID = (currentUser.StationID.HasValue ? currentUser.StationID : model.StationID) ?? default(int),
                    ModifiedAt = DateTime.Now,
                    ModifiedBy = currentUser.UserId,
                    InvoiceDetailId = addModel.ID,
                    CostPrice = item.Price,
                    SaleAmount = item.QuantityTaken,
                    CreatedAt = DateTime.Now,
                    CreatedBy = currentUser.UserId,
                    Date = model.Date,
                    IsActive = true
                };

                db.InvoiceDetailReports.Add(invoiceDetailReport);
            }

            db.SaveChanges();
        }

        private List<CostPriceResultModel> GetCostPrice(List<ImportOrderDetailState> lstState, InvoiceDetail invoiceDetail)
        {
            var result = new List<CostPriceResultModel>();
            var quantityLeft = invoiceDetail.SaleAmount;
            var allImportOrders = lstState.Where(x =>
            x.ImportOrderDetail.ProductID == invoiceDetail.ProductID
            && x.ImportOrderDetail.StationID == invoiceDetail.StationID && x.QuantityLeft > 0);
            foreach (var item in allImportOrders)
            {
                if (item.QuantityLeft >= invoiceDetail.SaleAmount)
                {
                    result.Add(new CostPriceResultModel()
                    {
                        ImportOrderId = item.ImportOrderDetail.ID,
                        Price = item.ImportOrderDetail.InputPrice,
                        QuantityTaken = invoiceDetail.SaleAmount
                    });
                    item.QuantityLeft -= invoiceDetail.SaleAmount;
                    break;
                }
                else
                {
                    result.Add(new CostPriceResultModel()
                    {
                        ImportOrderId = item.ImportOrderDetail.ID,
                        Price = item.ImportOrderDetail.InputPrice,
                        QuantityTaken = item.QuantityLeft
                    });

                    invoiceDetail.SaleAmount = invoiceDetail.SaleAmount - item.QuantityLeft;
                    item.QuantityLeft = 0;
                }
            }

            return result;
        }

        public ActionResult RecordLock(int id)
        {

            var removingObjects = db.Invoices.FirstOrDefault(x => x.ID == id);
            var invoiceChangeJson = removingObjects.ToJson();
            removingObjects.IsLock = !removingObjects.IsLock;
            ViewBag.status = removingObjects.IsLock;
            if (removingObjects.IsLock == true)
            {
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.BLOCK_INVOICE_ACTION,
                    FunctionName = DataFunctionNameConstant.BLOCK_INVOICE_FUNCTION,
                    DataTable = DataTableConstant.INVOICE,
                    Information = invoiceChangeJson
                };
                AddLogSystem.AddLog(log);
            }
            else
            {
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.UNBLOCK_INVOICE_ACTION,
                    FunctionName = DataFunctionNameConstant.UNBLOCK_INVOICE_FUNCTION,
                    DataTable = DataTableConstant.INVOICE,
                    Information = invoiceChangeJson
                };
                AddLogSystem.AddLog(log);
            }
            db.SaveChanges();
            return Json(new { ErrorMessage = string.Empty, currentIsLock = removingObjects.IsLock, ID = id }, JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        public JsonResult ProductChangeResult(ProductChangeResultModel model)
        {
            decimal totalSaleAmount = 0;
            decimal totalAvailableQuantity = 0;
            DateTime time = DateTime.ParseExact(model.Time, "dd/MM/yyyy HH:mm", CultureInfo.InvariantCulture);
            var invoiceDetails = from ids in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive)
                                 join iv in db.Invoices on ids.ParrentID equals iv.ID
                                 where ids.IsActive && iv.IsActive && ids.ProductID == model.ProductID && ids.StationID == model.StationID
                                 select ids;

            if (invoiceDetails != null && invoiceDetails.Any())
            {
                totalSaleAmount = invoiceDetails.Sum(x => x.SaleAmount);
            }

            var importDetails = from ids in db.ImportOrderDetails.Where(x => x.ImportOrder.IsActive)
                                join iv in db.ImportOrders on ids.ParrentID equals iv.ID
                                where ids.IsActive && iv.IsActive && ids.ProductID == model.ProductID && ids.StationID == model.StationID
                                select ids;

            if (importDetails != null && importDetails.Any())
            {
                totalAvailableQuantity = importDetails.Sum(x => x.InputNumber);
            }

            var quantityLeft = totalAvailableQuantity > totalSaleAmount ? totalAvailableQuantity - totalSaleAmount : 0;

            var joinProduct = from pd in db.Products
                              where (pd.IsActive && pd.ID == model.ProductID)
                              join lpr in db.ListedPrices on pd.ID equals lpr.ProductID into group2

                              from item2 in group2.DefaultIfEmpty()
                              where (item2.IsActive)
                              select new
                              {
                                  TimeApply = item2.TimeApply,
                                  ListedPrice = item2.PriceListed,
                              };
            var joinPrice = from pd in db.Products
                            where (pd.IsActive && pd.ID == model.ProductID)
                            join pr in db.Prices.Where(x => x.IsActive && x.StationID == model.StationID) on pd.ID equals pr.ProductID into group1

                            from item1 in group1.DefaultIfEmpty()
                            select new
                            {
                                TimeApply = item1.TimeApply,
                                Price = item1.Prices,
                            };
            var joinPriceAll = from pd in db.Products
                               where (pd.IsActive && pd.ID == model.ProductID)
                               join pr in db.Prices.Where(x => x.IsActive) on pd.ID equals pr.ProductID into group1

                               from item1 in group1.DefaultIfEmpty()
                               select new
                               {
                                   TimeApply = item1.TimeApply,
                                   Price = item1.Prices,
                                   StationId = item1.StationID
                               };

            decimal price = 0;
            var productPrice = joinPrice.Where(x => DbFunctions.TruncateTime(x.TimeApply) <= DbFunctions.TruncateTime(time)).OrderByDescending(x => x.TimeApply).FirstOrDefault();
            if (productPrice != null)
            {
                price = productPrice != null && productPrice.Price.HasValue ? productPrice.Price.Value : 0;
            }
            else
            {
                var productPriceall = joinPriceAll.Where(x => x.StationId == null && DbFunctions.TruncateTime(x.TimeApply) <= DbFunctions.TruncateTime(time)).OrderByDescending(x => x.TimeApply).FirstOrDefault();
                price = productPriceall != null && productPriceall.Price.HasValue ? productPriceall.Price.Value : 0;
            }
            var productJson = joinProduct.Where(x => DbFunctions.TruncateTime(x.TimeApply) <= DbFunctions.TruncateTime(time)).OrderByDescending(x => x.TimeApply).FirstOrDefault();
            var listprice = productJson != null ? productJson.ListedPrice : 0;


            var helper = new RecalculateHelper();
            var result = helper.GetCostPrice(db, model.ProductID.Value, model.StationID, new InvoiceDetail()
            {
                ProductID = model.ProductID.Value,
                StationID = model.StationID,
                SaleAmount = model.Amount
            });

            var costPrice = result.Any() && result.Sum(y => y.QuantityTaken) != 0 ? result.Sum(x => x.Price * x.QuantityTaken) / result.Sum(y => y.QuantityTaken) : 0;
            var productName = db.Products.FirstOrDefault(x => x.IsActive && (model.ProductID.HasValue ? x.ID == model.ProductID : x.IsActive));
            var productdisplayname = productName.ProductCode + ':' + productName.ProductName;

            // calculate freight charge
            dynamic freightChargeJson = null;
            if (costPrice > 0)
            {
                var discount = (listprice - ((decimal)1.1 * costPrice));
                if (discount < 0)
                {
                    discount = 0;
                }

                if (discount > 0)
                {
                    var freightCharge = from x in db.DealDetails.Where(x => x.FreightCharges.IsActive)
                                        where (x.IsActive == true && x.StationID == model.StationID && x.DiscountAmount > discount)
                                        select new { FreightCharge = x.FreightCharge, Discount = x.DiscountAmount };
                    freightChargeJson = freightCharge.OrderBy(x => x.Discount).FirstOrDefault();
                }
            }

            return Json(new ProductChangeResultModel
            {
                Price = price,
                ListedPrice = productJson != null ? productJson.ListedPrice : 0,
                QuantityLeft = quantityLeft,
                CostPrice = costPrice,
                FreightCharges = freightChargeJson != null ? freightChargeJson.FreightCharge : 0,
                ProductID = model.ProductID,
                totalAvailableQuantity = totalAvailableQuantity,
                ProductDisplayName = productdisplayname
            }, JsonRequestBehavior.AllowGet);
        }
    }
}