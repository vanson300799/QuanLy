using AutoMapper;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.SqlClient;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;
using WebModels.Constants;

namespace WEB.Areas.Admin.Controllers
{
    [PetroAuthorizeAttribute]
    public class InvoiceManageController : Controller
    {
        // GET: Admin/InvoiceManage
        WebContext db = new WebContext();

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        public ActionResult Index()
        {
            var datekey = db.NoteBookKeys.Select(x => x.DateTimeKey).FirstOrDefault();
            ViewBag.datekey = datekey;
            return View();
        }

        public ActionResult InvoiceManageDetailView(int? parentID)
        {
            var users = (from im in db.InvoiceManages.Where(x => x.IsActive && x.ID == parentID)
                         select new
                         {
                             invoiceCode = im.InvoiceCode

                         }).FirstOrDefault();

            ViewBag.InvoiceCode = "";
            if (parentID.HasValue)
            {
                ViewBag.InvoiceCode = users.invoiceCode;
            }
            ViewBag.parentID = parentID;
            return PartialView();
        }

        [AllowAnonymous]
        public ActionResult InvoiceManage_Read([DataSourceRequest] DataSourceRequest request)
        {
            var currentUser = UserInfoHelper.GetUserData();

            var users = from u in db.InvoiceManages.Where(x => x.IsActive && (!currentUser.StationID.HasValue || x.StationID == currentUser.StationID))
                        join cc in db.Customers on u.CustomerID equals cc.ID into group1

                        from item1 in group1.DefaultIfEmpty()
                        join sc in db.Stations on u.StationID equals sc.ID into group2

                        from item2 in group2.DefaultIfEmpty()
                        select new InvoiceManageViewModel
                        {
                            ID = u.ID,
                            Date = (DateTime)u.Date,
                            InvoiceCode = u.InvoiceCode,
                            CustomerName = item1.CustomerName,
                            StationName = item2.StationName,
                            Note = u.Note,
                            TotalSaleAmount = u.TotalSaleAmount,
                            Money = u.Money,
                            Tax = u.Tax,
                            TotalMoney = u.TotalMoney,
                            IsLock = u.IsLock
                        };


            return Json(users.ToDataSourceResult(request));
        }

        public ActionResult _InvoiceManageDetail([DataSourceRequest] DataSourceRequest request, int? id)
        {
            var detail = from u in db.InvoiceManageDetails.Where(x => x.IsActive && x.InvoiceManages.IsActive && x.ParentID == id)
                         join sc in db.Customers on u.CustomerID equals sc.ID into group1

                         from item1 in group1.DefaultIfEmpty()
                         join scs in db.Stations on u.StationID equals scs.ID into group2

                         from item2 in group2.DefaultIfEmpty()
                         join cc in db.Products on u.ProductID equals cc.ID into group3

                         from item3 in group3.DefaultIfEmpty()
                         select new InvoiceManageDetailViewModel
                         {
                             ID = u.ID,
                             Date = (DateTime)u.Date,
                             StationName = item2.StationName,
                             StationCode = item2.StationCode,
                             StationID = item2.ID,
                             ProductID = item3.ID,
                             ProductCode = item3.ProductCode,
                             ProductName = item3.ProductName,
                             SaleAmount = u.SaleAmount,
                             Price = u.Price,
                             Money = u.Money,
                             IsActive = u.IsActive,
                             CreatedAt = (DateTime)u.CreatedAt,
                             CreatedBy = u.CreatedBy,
                         };
            return Json(detail.ToList(), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult RecordLock(int id)
        {
            var removingObjects = db.InvoiceManages.FirstOrDefault(x => x.ID == id);
            var invoiceManageChangeJson = removingObjects.ToJson();
            removingObjects.IsLock = !removingObjects.IsLock;
            ViewBag.status = removingObjects.IsLock;
            db.SaveChanges();
            if (removingObjects.IsLock == true)
            {
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.BLOCK_INVOICE_MANAGE_ACTION,
                    FunctionName = DataFunctionNameConstant.BLOCK_INVOICE_MANAGE_FUNCTION,
                    DataTable = DataTableConstant.INVOICEMANAGE,
                    Information = invoiceManageChangeJson
                };
                AddLogSystem.AddLog(log);
            }
            else
            {
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.UNBLOCK_INVOICE_ACTION,
                    FunctionName = DataFunctionNameConstant.UNBLOCK_INVOICE_FUNCTION,
                    DataTable = DataTableConstant.INVOICEMANAGE,
                    Information = invoiceManageChangeJson
                };
                AddLogSystem.AddLog(log);
            }
            return Json(new { ErrorMessage = string.Empty, currentIsLock = removingObjects.IsLock, ID = id }, JsonRequestBehavior.AllowGet);
        }

        //kendoold
        public ActionResult Add()
        {
            var notbookey = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            ViewBag.notbookDate = notbookey.DateTimeKey.Value;
            var model = new InvoiceManageViewModel();
            model.DateString = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
            model.InvoiceManageDetails = db.InvoiceManageDetails.Where(x => x.ParentID == null);
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
        public ActionResult Add(InvoiceManageViewModel model)
        {

            var invoiceManagerChangeJson = model.ToJson();
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
            var currentUser = UserInfoHelper.GetUserData();

            if (ModelState.IsValid)
            {
                DateTime date = DateTime.Today;
                var firstDay = new DateTime(date.Year, date.Month, 1);

                var totalinvoice = (from iv in db.Set<Invoice>().AsNoTracking()
                                    where (iv.IsActive && (currentUser.StationID.HasValue ? iv.StationID == currentUser.StationID : iv.StationID == model.StationID)
                                    && (iv.CustomerID == model.CustomerID)
                                    && DbFunctions.TruncateTime(iv.Date) <= DbFunctions.TruncateTime(date) && DbFunctions.TruncateTime(iv.Date) >= DbFunctions.TruncateTime(firstDay))
                                    select iv
                                    ).ToList();
                var invoiceInMonthIds = totalinvoice.Select(x => x.ID);
                var invoiceDetals = db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive && invoiceInMonthIds.Contains(x.ParrentID));
                var dictionary = invoiceDetals.GroupBy(y => y.ProductID).ToDictionary(x => x.Key, x => x.Sum(z => z.SaleAmount));


                var temp = (from p in db.Set<InvoiceManage>().AsNoTracking().Where(x => x.IsActive)
                            where p.InvoiceCode.Equals(model.InvoiceCode, StringComparison.OrdinalIgnoreCase)
                            select p).FirstOrDefault();

                if (temp != null)
                {
                    return Json(new { ErrorMessage = "Mã đơn hàng đã tồn tại!" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    if (model.InvoiceManageDetails == null)
                    {
                        return Json(new { ErrorMessage = "Chi tiết đơn nhập hàng không được để trống" }, JsonRequestBehavior.AllowGet);
                    }

                    if (currentUser.StationID.HasValue)
                    {
                        foreach (var item in model.InvoiceManageDetails)
                        {
                            item.StationID = currentUser.StationID.Value;
                        }
                    }

                    try
                    {
                        using (DbContextTransaction transaction = db.Database.BeginTransaction())
                        {
                            List<InvoiceManageDetail> listadd = new List<InvoiceManageDetail>();

                            var modelDetail = model.InvoiceManageDetails;
                            decimal totalSaleAmount = 0;
                            decimal totalMoney = 0;
                            if (modelDetail != null)
                            {
                                foreach (var item in modelDetail)
                                {
                                    totalMoney += item.Money;
                                    totalSaleAmount += item.SaleAmount;
                                }
                            }

                            InvoiceManage invoiceManage = new InvoiceManage
                            {
                                Date = model.Date,
                                CustomerID = model.CustomerID ?? default(int),
                                StationID = model.StationID ?? default(int),
                                Note = model.Note,
                                CreatedAt = DateTime.Now,
                                CreatedBy = currentUser.UserId,
                                TotalSaleAmount = totalSaleAmount,
                                InvoiceCode = model.InvoiceCode,
                                Money = totalMoney,
                                Tax = (totalMoney * 10) / 100,
                                TotalMoney = totalMoney + (totalMoney * 10) / 100,
                                IsActive = true,
                                IsLock = false
                            };

                            db.InvoiceManages.Add(invoiceManage);
                            db.SaveChanges();
                            try
                            {
                                foreach (var item in modelDetail)
                                {
                                    var invoiceManageDetail = new InvoiceManageDetail
                                    {
                                        ProductID = item.ProductID,
                                        StationID = invoiceManage.StationID,
                                        SaleAmount = item.SaleAmount,
                                        Price = item.Price,
                                        Money = item.Money,
                                        ParentID = invoiceManage.ID,
                                        CustomerID = invoiceManage.CustomerID,
                                        Date = invoiceManage.Date,
                                        CreatedAt = DateTime.Now,
                                        CreatedBy = currentUser.UserId,
                                        IsActive = true
                                    };
                                    listadd.Add(invoiceManageDetail);
                                }

                                foreach (var item in listadd)
                                {
                                    AddInvoiceManageDetail(item);
                                    totalSaleAmount += item.SaleAmount;
                                    totalMoney += item.Money;

                                }
                                LogSystem log = new LogSystem
                                {
                                    ActiveType = DataActionTypeConstant.ADD_INVOICEMANAGE_ACTION,
                                    FunctionName = DataFunctionNameConstant.ADD_INVOICEMANAGE_FUNCTION,
                                    DataTable = DataTableConstant.INVOICEMANAGE,
                                    Information = invoiceManagerChangeJson
                                };

                                // re-calculate revenue
                                var helper = new RecalculateHelper();
                                var invoiceInMonth = db.Invoices.Where(x => x.IsActive && (!currentUser.StationID.HasValue || currentUser.StationID == 0 || x.StationID == currentUser.StationID) &&
                        x.Date.Month == DateTime.Now.Month && x.Date.Year == DateTime.Now.Year).ToList();

                                var invoiceIds = invoiceInMonth.Select(x => x.ID);
                                var invoiceDetailInMonth = db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive && x.InvoiceDetail.Invoice.IsActive && invoiceIds.Contains(x.ParrentID)).ToList();

                                helper.CaculateInvoiceRevenue(listadd.ToList(), invoiceDetailInMonth);

                                var invoicemanage = (from iv in db.Set<InvoiceManage>().AsNoTracking()
                                                     where (iv.IsActive && (currentUser.StationID.HasValue ? iv.StationID == currentUser.StationID : iv.StationID == model.StationID)
                                                     && (iv.CustomerID == model.CustomerID)
                                                     && DbFunctions.TruncateTime(iv.Date) <= DbFunctions.TruncateTime(date) && DbFunctions.TruncateTime(iv.Date) >= DbFunctions.TruncateTime(firstDay))
                                                     select iv
                                    ).ToList();
                                var invoicemanageInMonthIds = invoicemanage.Select(x => x.ID);
                                var invoicemanageDetail = db.InvoiceManageDetails.Where(x => x.IsActive && x.InvoiceManages.IsActive && invoicemanageInMonthIds.Contains(x.ParentID));

                                var dictionaryin = invoicemanageDetail.GroupBy(y => y.ProductID).ToDictionary(x => x.Key, x => x.Sum(z => z.SaleAmount));
                                //foreach (var key in dictionary.Keys)
                                //{
                                //    if (dictionaryin.ContainsKey(key) && dictionary[key] < dictionaryin[key])
                                //    {
                                //        ModelState.AddModelError("", WebResources.InvoiceManageNotValid);
                                //        return Json(new { ErrorMessage = WebResources.InvoiceManageNotValid }, JsonRequestBehavior.AllowGet);
                                //    }
                                //}

                                AddLogSystem.AddLog(log);
                                transaction.Commit();
                                return View(model);
                            }
                            catch (Exception ex)
                            {
                                transaction.Rollback();
                                ModelState.AddModelError("", ex.Message);
                                return Json(new { ErrorMessage = string.Format("Đã xảy ra lỗi, chi tiết lỗi: \n{0}", ex.Message) }, JsonRequestBehavior.AllowGet);
                            }
                        }
                    }
                    catch (Exception ex)
                    {
                        ModelState.AddModelError("", string.Format("Đã xảy ra lỗi, chi tiết lỗi: \n{0}", ex.Message));
                        return Json(new { ErrorMessage = string.Format("Đã xảy ra lỗi, chi tiết lỗi: \n{0}", ex.Message) }, JsonRequestBehavior.AllowGet);
                    }
                }
            }
            else
            {
                return Json(new { ErrorMessage = string.Empty }, JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult Edit(int id)
        {
            var notbookey = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            ViewBag.notbookDate = notbookey.DateTimeKey.Value;
            var model = db.Set<InvoiceManage>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            var viewModel = GetInvoiceManageViewModel(model, id);
            viewModel.CurrentInvoiceCode = model.InvoiceCode;
            viewModel.DateString = viewModel.Date.ToString("dd/MM/yyyy HH:mm");
            return View("Edit", viewModel);
        }

        private InvoiceManageViewModel GetInvoiceManageViewModel(InvoiceManage model, int id)
        {
            var config = new MapperConfiguration(cfg => cfg.CreateMap<InvoiceManage, InvoiceManageViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<InvoiceManageViewModel>(model);
            viewModel.InvoiceManageDetails = db.InvoiceManageDetails.Where(x => x.IsActive && x.InvoiceManages.IsActive && x.ParentID == model.ID).AsNoTracking().ToList();
            var station = db.Stations.Where(x => x.ID == viewModel.StationID).FirstOrDefault();
            if (station != null)
            {
                viewModel.StationName = station.StationName;
            }
            return viewModel;
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(InvoiceManageViewModel model)
        {
            var invoiceManagerObj = db.InvoiceManages.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
            var oldViewModel = GetInvoiceManageViewModel(invoiceManagerObj, model.ID);
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
            var currentUser = UserInfoHelper.GetUserData();

            if (ModelState.IsValid)
            {
                DateTime date = DateTime.Today;
                var firstDay = new DateTime(date.Year, date.Month, 1);

                var totalinvoice = (from iv in db.Set<Invoice>().AsNoTracking()
                                    where (iv.IsActive && (currentUser.StationID.HasValue ? iv.StationID == currentUser.StationID : iv.StationID == model.StationID)
                                    && (iv.CustomerID == model.CustomerID)
                                    && DbFunctions.TruncateTime(iv.Date) <= DbFunctions.TruncateTime(date) && DbFunctions.TruncateTime(iv.Date) >= DbFunctions.TruncateTime(firstDay))
                                    select iv
                                    ).ToList();
                var invoiceInMonthIds = totalinvoice.Select(x => x.ID);
                var invoiceDetals = db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive && invoiceInMonthIds.Contains(x.ParrentID));
                var dictionary = invoiceDetals.GroupBy(y => y.ProductID).ToDictionary(x => x.Key, x => x.Sum(z => z.SaleAmount));

                var temp = (from p in db.Set<InvoiceManage>().AsNoTracking()
                            where p.IsActive && (p.InvoiceCode.Equals(model.InvoiceCode, StringComparison.OrdinalIgnoreCase) && p.InvoiceCode != model.CurrentInvoiceCode)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    return Json(new { ErrorMessage = "Mã đơn hàng đã tồn tại!" }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    if (model.InvoiceManageDetails == null)
                    {
                        return Json(new { ErrorMessage = "Chi tiết đơn nhập hàng không được để trống" }, JsonRequestBehavior.AllowGet);
                    }

                    try
                    {
                        using (DbContextTransaction transaction = db.Database.BeginTransaction())
                        {
                            try
                            {
                                List<InvoiceManageDetail> listedit = new List<InvoiceManageDetail>();
                                List<InvoiceManageDetail> listadd = new List<InvoiceManageDetail>();
                                List<InvoiceManageDetail> listdelete = new List<InvoiceManageDetail>();

                                var modelDetail = model.InvoiceManageDetails;
                                int? parentIDmodel = db.InvoiceManageDetails.Where(x => x.IsActive && x.InvoiceManages.IsActive && x.ParentID == model.ID).Select(x => x.ParentID).FirstOrDefault();
                                var modelDB = db.InvoiceManageDetails.Where(x => x.IsActive && x.InvoiceManages.IsActive && x.ParentID == parentIDmodel);
                                var validmodelDB = modelDB.Count();
                                decimal totalSaleAmount = 0;
                                decimal totalMoney = 0;
                                if (parentIDmodel != 0 && validmodelDB != 0)
                                {
                                    totalSaleAmount = db.InvoiceManageDetails.Where(x => x.IsActive && x.InvoiceManages.IsActive && x.ParentID == parentIDmodel).Sum(a => a.SaleAmount);
                                    totalMoney = db.InvoiceManageDetails.Where(x => x.IsActive && x.InvoiceManages.IsActive && x.ParentID == parentIDmodel).Sum(a => a.Money);
                                }

                                if (modelDetail != null)
                                {
                                    foreach (var item in modelDetail)
                                    {
                                        var invoiceManageDetail = new InvoiceManageDetail
                                        {
                                            ID = item.ID,
                                            ProductID = item.ProductID,
                                            StationID = model.StationID,
                                            SaleAmount = item.SaleAmount,
                                            Price = item.Price,
                                            Money = item.Money,
                                            Date = model.Date,
                                            ParentID = model.ID,
                                            CustomerID = model.CustomerID ?? default(int),
                                            ModifiedAt = DateTime.Now,
                                            ModifiedBy = currentUser.UserId,
                                        };
                                        if (item.ID != 0)
                                        {
                                            listedit.Add(invoiceManageDetail);
                                        }
                                        else
                                        {
                                            listadd.Add(invoiceManageDetail);
                                        }
                                    }
                                }
                                if (listadd != null)
                                {
                                    foreach (var item in listedit)
                                    {
                                        var detailedit = db.InvoiceManageDetails.Where(x => x.ID == item.ID).Select(x => x.Money).FirstOrDefault();
                                        var inputedit = db.InvoiceManageDetails.Where(x => x.ID == item.ID).Select(x => x.SaleAmount).FirstOrDefault();
                                        totalMoney += (item.Money - detailedit);
                                        totalSaleAmount += (item.SaleAmount - inputedit);
                                        db.InvoiceManageDetails.Attach(item);
                                        db.Entry(item).Property(a => a.ID).IsModified = false;
                                        db.Entry(item).Property(a => a.ParentID).IsModified = true;
                                        db.Entry(item).Property(a => a.Date).IsModified = true;
                                        db.Entry(item).Property(a => a.ProductID).IsModified = true;
                                        db.Entry(item).Property(a => a.StationID).IsModified = true;
                                        db.Entry(item).Property(a => a.SaleAmount).IsModified = true;
                                        db.Entry(item).Property(a => a.Price).IsModified = true;
                                        db.Entry(item).Property(a => a.Money).IsModified = true;
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
                                        totalMoney -= item.Money;
                                        totalSaleAmount -= item.SaleAmount;
                                        var remove = db.InvoiceManageDetails.FirstOrDefault(x => x.ID == item.ID);
                                        remove.IsActive = false;
                                    }
                                }
                                db.SaveChanges();
                                if (listadd != null)
                                {
                                    foreach (var item in listadd)
                                    {
                                        totalMoney += item.Money;
                                        totalSaleAmount += item.SaleAmount;
                                        AddInvoiceManageDetail(item);
                                    }
                                }

                                InvoiceManage invoiceManage = new InvoiceManage
                                {
                                    ID = model.ID,
                                    CustomerID = model.CustomerID ?? default(int),
                                    Note = model.Note,
                                    StationID = model.StationID ?? default(int),
                                    TotalSaleAmount = totalSaleAmount,
                                    Money = totalMoney,
                                    Date = model.Date,
                                    Tax = (totalMoney * 10) / 100,
                                    TotalMoney = totalMoney + (totalMoney * 10) / 100,
                                    InvoiceCode = model.InvoiceCode
                                };

                                db.InvoiceManages.Attach(invoiceManage);
                                db.Entry(invoiceManage).Property(a => a.ID).IsModified = false;
                                db.Entry(invoiceManage).Property(a => a.StationID).IsModified = true;
                                db.Entry(invoiceManage).Property(a => a.InvoiceCode).IsModified = true;
                                db.Entry(invoiceManage).Property(a => a.Date).IsModified = true;
                                db.Entry(invoiceManage).Property(a => a.TotalSaleAmount).IsModified = true;
                                db.Entry(invoiceManage).Property(a => a.TotalMoney).IsModified = true;
                                db.Entry(invoiceManage).Property(a => a.CustomerID).IsModified = true;
                                db.Entry(invoiceManage).Property(a => a.Note).IsModified = true;
                                db.Entry(invoiceManage).Property(a => a.Tax).IsModified = true;
                                db.Entry(invoiceManage).Property(a => a.Money).IsModified = true;
                                db.SaveChanges();

                                var oldJson = oldViewModel.ToJson();
                                var newJson = model.ToJson();
                                LogSystem log = new LogSystem
                                {
                                    ActiveType = DataActionTypeConstant.UPDATE_INVOICEMANAGE_ACTION,
                                    FunctionName = DataFunctionNameConstant.UPDATE_INVOICMANAGE_FUNCTION,
                                    DataTable = DataTableConstant.INVOICEMANAGE,
                                    Information = string.Format("Trước khi thay đổi: {0} Sau khi thay đổi: {1}", oldJson, newJson)
                                };

                                // re-calculate revenue
                                var helper = new RecalculateHelper();
                                var invoiceInMonth = db.Invoices.Where(x => x.IsActive && (!currentUser.StationID.HasValue || currentUser.StationID == 0 || x.StationID == currentUser.StationID) &&
                        x.Date.Month == DateTime.Now.Month && x.Date.Year == DateTime.Now.Year).ToList();

                                var invoiceIds = invoiceInMonth.Select(x => x.ID);
                                var invoiceDetailInMonth = db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive && x.InvoiceDetail.Invoice.IsActive && invoiceIds.Contains(x.ParrentID)).ToList();

                                helper.CaculateInvoiceRevenue(listadd.ToList(), invoiceDetailInMonth);

                                var invoicemanage = (from iv in db.Set<InvoiceManage>().AsNoTracking()
                                                     where (iv.IsActive && (currentUser.StationID.HasValue ? iv.StationID == currentUser.StationID : iv.StationID == model.StationID)
                                                     && (iv.CustomerID == model.CustomerID)
                                                     && DbFunctions.TruncateTime(iv.Date) <= DbFunctions.TruncateTime(date) && DbFunctions.TruncateTime(iv.Date) >= DbFunctions.TruncateTime(firstDay))
                                                     select iv
                                    ).ToList();
                                var invoicemanageInMonthIds = invoicemanage.Select(x => x.ID);
                                var invoicemanageDetail = db.InvoiceManageDetails.Where(x => x.IsActive && x.InvoiceManages.IsActive && invoicemanageInMonthIds.Contains(x.ParentID));

                                var dictionaryin = invoicemanageDetail.GroupBy(y => y.ProductID).ToDictionary(x => x.Key, x => x.Sum(z => z.SaleAmount));
                                //foreach (var key in dictionary.Keys)
                                //{
                                //    if (dictionaryin.ContainsKey(key) && dictionary[key] < dictionaryin[key])
                                //    {
                                //        ModelState.AddModelError("", WebResources.InvoiceManageNotValid);
                                //        return Json(new { ErrorMessage = WebResources.InvoiceManageNotValid }, JsonRequestBehavior.AllowGet);
                                //    }
                                //}

                                AddLogSystem.AddLog(log);
                                transaction.Commit();
                                return View(model);
                            }
                            catch (Exception)
                            {
                                transaction.Rollback();
                            }
                            return View(model);
                        }
                    }
                    catch (Exception ex)
                    {

                        ModelState.AddModelError("", ex.Message);
                        return View(model);
                    }
                }
            }
            else
            {
                return View(model);
            }

        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult InvoiceManage_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<InvoiceManage> models)
        {
            var invoiceManageChangeJson = models.ToJson();


            foreach (var model in models)
            {
                var removingObjects = db.InvoiceManages.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
                var listremovedetail = db.InvoiceManageDetails.Where(x => x.ParentID == model.ID).ToList();
                foreach (var item in listremovedetail)
                {
                    item.IsActive = false;
                }
            }

            var count = db.SaveChanges();

            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_INVOICEMANAGE_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_INVOICE_FUNCTION,
                DataTable = DataTableConstant.INVOICEMANAGE,
                Information = invoiceManageChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.Count() == count);
        }

        public void AddInvoiceManageDetail(InvoiceManageDetail model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            InvoiceManageDetail addModel = new InvoiceManageDetail
            {
                ProductID = model.ProductID,
                ParentID = model.ParentID,
                CustomerID = model.CustomerID,
                SaleAmount = model.SaleAmount,
                Price = model.Price,
                Money = (model.SaleAmount) * (model.Price),
                CreatedAt = DateTime.Now,
                CreatedBy = currentUser.UserId,
                Date = model.Date,
                IsActive = true,
                StationID = model.StationID.HasValue ? model.StationID.Value : currentUser.StationID
            };
            db.InvoiceManageDetails.Add(addModel);
            db.SaveChanges();
        }

        private void RecalculateRevenue(InvoiceManage invoiceManage, List<InvoiceManageDetail> invoiceManageDetails)
        {
            var invoiceInMonth = db.Invoices.Where(x => x.CustomerID == invoiceManage.CustomerID && (invoiceManage.StationID == 0 || x.StationID == invoiceManage.StationID) &&
            x.Date.Month == DateTime.Now.Month && x.Date.Year == DateTime.Now.Year);
            var invoiceIds = invoiceInMonth.Select(x => x.ID);
            var invoiceDetailInMonth = db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive && invoiceIds.Contains(x.ParrentID)).ToList();

            var contractInvoice = invoiceDetailInMonth.Where(x => x.InvoiceType == "Hợp đồng");
            var cashInvoice = invoiceDetailInMonth.Where(x => x.InvoiceType == "Tiền mặt");
            var cashDbtInvoice = invoiceDetailInMonth.Where(x => x.InvoiceType == "Nợ tiền mặt");

            foreach (var invoiceManageDetail in invoiceManageDetails)
            {
                var costUnit = ((double)invoiceManageDetail.Money * 6.5 / 100) / (double)invoiceManageDetail.SaleAmount;
                var productInvoiceDetails = invoiceDetailInMonth.Where(x => x.ProductID == invoiceManageDetail.ProductID);
                var totalSaleQuantityInvoiceManage = invoiceManageDetails.Where(y => y.ProductID == invoiceManageDetail.ProductID).Sum(x => x.SaleAmount);
                var totalSaleQuantityLeft = totalSaleQuantityInvoiceManage;
                foreach (var productInvoiceDetail in productInvoiceDetails)
                {
                    if (totalSaleQuantityLeft <= 0)
                    {
                        break;
                    }

                    if (productInvoiceDetail.InvoiceType == "Tiền mặt" || productInvoiceDetail.InvoiceType == "Nợ tiền mặt")
                    {
                        //var revenue = 
                    }

                    totalSaleQuantityLeft = totalSaleQuantityLeft - productInvoiceDetail.SaleAmount;
                }
            }
        }
        [HttpPost]
        public ActionResult ExportExcel(InvoiceManageViewModel data)
        {

            List<InvoiceManageViewModel> listData = new List<InvoiceManageViewModel>();
            var dataListJson = data.DataExport.Replace('?','"');
            var dataObjSplit0 = dataListJson.Split('[');
            var dataObjSplit1 = dataObjSplit0[1].Split('}');
            for (var i = 0; i < (dataObjSplit1.Count() - 1); i++)
            {
                InvoiceManageViewModel dataObj = null;
                var dataObjString = string.Empty;
                if (i == 0)
                {
                    dataObjString = dataObjSplit1[i] + "}";
                }
                else
                {
                    var dataObjString0 = dataObjSplit1[i].Substring(1);
                    dataObjString = dataObjString0 + "}";
                }
                dataObj = JsonConvert.DeserializeObject<InvoiceManageViewModel>(dataObjString);
                dataObj.Date = dataObj.Date.ToLocalTime();
                listData.Add(dataObj);
            }
            var result = DownloadInvoiceManage(listData.OrderByDescending(x => x.Date).ToList());
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Quan_Ly_Hoa_Don.xlsx");
        }

        public byte[] DownloadInvoiceManage(List<InvoiceManageViewModel> models)
        {

            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            var fileinfo = new FileInfo(string.Format(@"{0}\InvoiceManage.xlsx", HostingEnvironment.MapPath("/Uploads")));
            if (fileinfo.Exists)
            {
                var countView = 0;
                foreach (var item in models)
                {
                    countView += 1;
                    item.Count = countView;
                }
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    productWorksheet.Select();
                    productWorksheet.Cells[1, 1].Value = "QUẢN LÝ HOÁ ĐƠN";
                    //border
                    var modelTable = productWorksheet.Cells[1, 1, models.Count() + 5, 9];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    if (models.Count != 0)
                    {
                        for (int i = 0; i < models.Count(); i++)
                        {
                            productWorksheet.Cells[i + 4, 1].Value = models[i].Date;
                            productWorksheet.Cells[i + 4, 2].Value = models[i].InvoiceCode;
                            productWorksheet.Cells[i + 4, 3].Value = models[i].CustomerName;
                            productWorksheet.Cells[i + 4, 4].Value = models[i].StationName;
                            productWorksheet.Cells[i + 4, 5].Value = models[i].Note;
                            productWorksheet.Cells[i + 4, 6].Value = models[i].TotalSaleAmount;
                            productWorksheet.Cells[i + 4, 7].Value = models[i].Money;
                            productWorksheet.Cells[i + 4, 8].Value = models[i].Tax;
                            productWorksheet.Cells[i + 4, 9].Value = models[i].TotalMoney;


                            productWorksheet.Cells[i + 4, 6].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 4, 7].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 4, 8].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 4, 9].Style.Numberformat.Format = "#,##0.00";
                        }
                        productWorksheet.Cells[models.Count() + 5, 1].Value = "Tổng";
                        productWorksheet.Cells[models.Count() + 5, 6].Formula = "=SUM(" + productWorksheet.Cells[4, 6, models.Count() + 4, 6] + ")";
                        productWorksheet.Cells[models.Count() + 5, 7].Formula = "=SUM(" + productWorksheet.Cells[4, 7, models.Count() + 4, 7] + ")";
                        productWorksheet.Cells[models.Count() + 5, 8].Formula = "=SUM(" + productWorksheet.Cells[4, 8, models.Count() + 4, 8] + ")";
                        productWorksheet.Cells[models.Count() + 5, 9].Formula = "=SUM(" + productWorksheet.Cells[4, 9, models.Count() + 4, 9] + ")";

                        productWorksheet.Cells[models.Count() + 5, 1, models.Count() + 5, 9].Style.Font.Bold = true;
                        productWorksheet.Cells[models.Count() + 5, 6].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[models.Count() + 5, 7].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[models.Count() + 5, 8].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[models.Count() + 5, 9].Style.Numberformat.Format = "#,##0.00";

                        return p.GetAsByteArray();
                    }
                    else
                    {
                        return p.GetAsByteArray();
                    }
                }
            }
            else
            {
                return null;
            }
        }
    }
}