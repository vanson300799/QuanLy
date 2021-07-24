using AutoMapper;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;
using WebModels.Constants;

namespace WEB.Areas.Admin.Controllers
{
    [PetroAuthorizeAttribute]
    public class ImportOrderController : Controller
    {
        // GET: Admin/ImportOrder
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

        public ActionResult IndexChildView(int? parrentID)
        {
            ViewBag.parentID = parrentID;

            return PartialView();
        }

        [AllowAnonymous]
        public ActionResult ImportOrder_Read([DataSourceRequest] DataSourceRequest request)
        {
            var currentUser = UserInfoHelper.GetUserData();

            var users = from u in db.ImportOrders.Where(x => x.IsActive && (!currentUser.StationID.HasValue || x.StationID == currentUser.StationID))
                        join cc in db.Suppliers on u.SupplierID equals cc.ID into group1

                        from item1 in group1.DefaultIfEmpty()
                        join sc in db.Stations on u.StationID equals sc.ID into group2

                        from item2 in group2.DefaultIfEmpty()
                        select new ImportOrderViewModel
                        {
                            ID = u.ID,
                            Date = (DateTime)u.Date,
                            InvoiceCode = u.InvoiceCode,
                            SupplierName = item1.SupplierName,
                            TotalQuantity = u.TotalQuantity,
                            TotalMoney = u.TotalMoney,
                            StationName = item2.StationName,
                            Information = u.Information,
                            IsLock = u.IsLock
                        };


            return Json(users.ToDataSourceResult(request));
        }

        public ActionResult _ImportOrdersChild([DataSourceRequest] DataSourceRequest request, int? id)
        {
            var currentUser = UserInfoHelper.GetUserData();
            if (currentUser.StationID != null)
            {
                var detailStaff = from u in db.ImportOrderDetails.Where(x => x.IsActive && x.ImportOrder.IsActive && x.ParrentID == id && x.StationID == currentUser.StationID)
                             join sc in db.Suppliers on u.SupplierID equals sc.ID into group1

                             from item1 in group1.DefaultIfEmpty()
                             join scs in db.Stations on u.StationID equals scs.ID into group2

                             from item2 in group2.DefaultIfEmpty()
                             join cc in db.Products on u.ProductID equals cc.ID into group3

                             from item3 in group3.DefaultIfEmpty()
                             select new ImportOrderDetailViewModel
                             {
                                 ID = u.ID,
                                 Date = (DateTime)u.Date,
                                 SupplierName = item1.SupplierName,
                                 StationName = item2.StationName,
                                 StationCode = item2.StationCode,
                                 StationID = item2.ID,
                                 ProductID = item3.ID,
                                 ProductCode = item3.ProductCode,
                                 ProductName = item3.ProductName,
                                 InputNumber = u.InputNumber,
                                 InputPrice = u.InputPrice,
                                 Money = (u.InputNumber) * (u.InputPrice),
                                 IsActive = u.IsActive,
                                 CreatedAt = (DateTime)u.CreatedAt,
                                 CreatedBy = u.CreatedBy,
                             };
                return Json(detailStaff.ToList(), JsonRequestBehavior.AllowGet);
            }
            var detail = from u in db.ImportOrderDetails.Where(x => x.IsActive && x.ImportOrder.IsActive && x.ParrentID == id)
                         join sc in db.Suppliers on u.SupplierID equals sc.ID into group1

                         from item1 in group1.DefaultIfEmpty()
                         join scs in db.Stations on u.StationID equals scs.ID into group2

                         from item2 in group2.DefaultIfEmpty()
                         join cc in db.Products on u.ProductID equals cc.ID into group3

                         from item3 in group3.DefaultIfEmpty()
                         select new ImportOrderDetailViewModel
                         {
                             ID = u.ID,
                             Date = (DateTime)u.Date,
                             SupplierName = item1.SupplierName,
                             StationName = item2.StationName,
                             StationCode = item2.StationCode,
                             StationID = item2.ID,
                             ProductID = item3.ID,
                             ProductCode = item3.ProductCode,
                             ProductName = item3.ProductName,
                             InputNumber = u.InputNumber,
                             InputPrice = u.InputPrice,
                             Money = (u.InputNumber) * (u.InputPrice),
                             IsActive = u.IsActive,
                             CreatedAt = (DateTime)u.CreatedAt,
                             CreatedBy = u.CreatedBy,
                         };
            return Json(detail.ToList(), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult RecordLock(int id)
        {
            var removingObjects = db.ImportOrders.FirstOrDefault(x => x.ID == id);
            removingObjects.IsLock = !removingObjects.IsLock;
            var importOrderChangeJson = removingObjects.ToJson();
            if (removingObjects.IsLock == true)
            {
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.BLOCK_IMPORT_ORDER_ACTION,
                    FunctionName = DataFunctionNameConstant.BLOCK_IMPORT_ORDER_FUNCTION,
                    DataTable = DataTableConstant.IMPORT_ORDER,
                    Information = importOrderChangeJson
                };
                AddLogSystem.AddLog(log);
            }
            else
            {
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.UNBLOCK_IMPORT_ORDER_ACTION,
                    FunctionName = DataFunctionNameConstant.UNBLOCK_IMPORT_ORDER_FUNCTION,
                    DataTable = DataTableConstant.IMPORT_ORDER,
                    Information = importOrderChangeJson
                };
                AddLogSystem.AddLog(log);
            }
            ViewBag.status = removingObjects.IsLock;
            db.SaveChanges();
            return Json(new { ErrorMessage = string.Empty, currentIsLock = removingObjects.IsLock, ID = id }, JsonRequestBehavior.AllowGet);
        }

        //kendoold
        public ActionResult Add()
        {
            var model = new ImportOrderViewModel();
            model.DateString = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
            model.ImportOrdersDetails = db.ImportOrderDetails.Where(x => x.ParrentID == null);
            var currentUser = UserInfoHelper.GetUserData();
            var notbookey = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            ViewBag.notbookDate = notbookey.DateTimeKey.Value;

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
        public ActionResult Add([Bind(Exclude = "")] ImportOrderViewModel model)
        {
            var importOrderChangeJson = model.ToJson();
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
                var temp = (from p in db.Set<ImportOrder>().AsNoTracking()
                            where (p.InvoiceCode.Equals(model.InvoiceCode, StringComparison.OrdinalIgnoreCase) && p.IsActive)
                            select p).FirstOrDefault();

                if (temp != null)
                {
                    return Json(new { ErrorMessage = WebResources.InvoiceCodeExists }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    if (model.ImportOrdersDetails == null)
                    {
                        ViewBag.StartupScript = "alerterror();";
                        return View(model);
                    }

                    if (currentUser.StationID.HasValue)
                    {
                        foreach (var item in model.ImportOrdersDetails)
                        {
                            item.StationID = currentUser.StationID.Value;
                        }
                    }

                    try
                    {
                        using (DbContextTransaction transaction = db.Database.BeginTransaction())
                        {
                            List<ImportOrderDetail> listadd = new List<ImportOrderDetail>();

                            var modelDetail = model.ImportOrdersDetails;
                            decimal countdetail = 0;
                            decimal totaldetail = 0;
                            if (modelDetail != null)
                            {
                                foreach (var item in modelDetail)
                                {
                                    totaldetail += item.Money;
                                    countdetail += item.InputNumber;
                                }
                            }

                            ImportOrder importOrder = new ImportOrder
                            {
                                Date = model.Date,
                                SupplierID = model.SupplierID,
                                StationID = currentUser.StationID.HasValue? currentUser.StationID.Value: model.StationID,
                                Information = model.Information,
                                CreatedAt = DateTime.Now,
                                CreatedBy = currentUser.UserId,
                                TotalQuantity = countdetail,
                                InvoiceCode = model.InvoiceCode,
                                TotalMoney = totaldetail,
                                IsActive = true,
                                IsLock = false
                            };

                            db.ImportOrders.Add(importOrder);
                            db.SaveChanges();
                            try
                            {
                                foreach (var item in modelDetail)
                                {
                                    var importOrderDetail = new ImportOrderDetail
                                    {
                                        ProductID = item.ProductID,
                                        StationID = item.StationID,
                                        InputNumber = item.InputNumber,
                                        InputPrice = item.InputPrice,
                                        Money = item.Money,
                                        ParrentID = importOrder.ID,
                                        SupplierID = importOrder.SupplierID,
                                        Date = importOrder.Date,
                                        CreatedAt = DateTime.Now,
                                        CreatedBy = currentUser.UserId,
                                        IsActive = true
                                    };
                                    listadd.Add(importOrderDetail);
                                }

                                foreach (var item in listadd)
                                {
                                    AddImportOderDetail(item);
                                    countdetail += item.InputNumber;
                                    totaldetail += item.Money;

                                }
                                LogSystem log = new LogSystem
                                {
                                    ActiveType = DataActionTypeConstant.ADD_IMPORT_ORDER_ACTION,
                                    FunctionName = DataFunctionNameConstant.ADD_IMPORT_ORDER_FUNCTION,
                                    DataTable = DataTableConstant.IMPORT_ORDER,
                                    Information = importOrderChangeJson
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

        public ActionResult Edit(int id)
        {
            var notbookey = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            ViewBag.notbookDate = notbookey.DateTimeKey.Value;
            var model = db.Set<ImportOrder>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            var viewModel = GetImportOrderViewModel(model, id);
            ViewBag.cBillID = model.InvoiceCode;

            viewModel.DateString = viewModel.Date.ToString("dd/MM/yyyy HH:mm");
            viewModel.CurrentBillID = model.InvoiceCode;
            return View("Edit", viewModel);
        }

        private ImportOrderViewModel GetImportOrderViewModel(ImportOrder model, int id)
        {
            var config = new MapperConfiguration(cfg => cfg.CreateMap<ImportOrder, ImportOrderViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<ImportOrderViewModel>(model);
            viewModel.ImportOrdersDetails = db.ImportOrderDetails.Where(x => x.ParrentID == model.ID).AsNoTracking();
            viewModel.DateString = DateTime.Now.ToString();

            var station = db.Stations.Where(x => x.ID == viewModel.StationID).AsNoTracking().FirstOrDefault();
            if (station != null)
            {
                viewModel.StationName = station.StationName;
            }
            return viewModel;
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(ImportOrderViewModel model)
        {
            var importOrderObj = db.ImportOrders.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
            var oldModel = GetImportOrderViewModel(importOrderObj,model.ID);
            var oldJson = oldModel.ToJson();
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
                var temp = (from p in db.Set<ImportOrder>().AsNoTracking()
                            where (p.InvoiceCode.Equals(model.InvoiceCode, StringComparison.OrdinalIgnoreCase) && p.IsActive && p.InvoiceCode != model.CurrentBillID)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    return Json(new { ErrorMessage = WebResources.InvoiceCodeExists }, JsonRequestBehavior.AllowGet);
                }
                else
                {
                    if (model.ImportOrdersDetails == null)
                    {
                        return Json(new { ErrorMessage = "Chi tiết đơn nhập hàng không được để trống" }, JsonRequestBehavior.AllowGet);
                    }

                    try
                    {
                        using (DbContextTransaction transaction = db.Database.BeginTransaction())
                        {
                            try
                            {
                                List<ImportOrderDetail> listedit = new List<ImportOrderDetail>();
                                List<ImportOrderDetail> listadd = new List<ImportOrderDetail>();
                                List<ImportOrderDetail> listdelete = new List<ImportOrderDetail>();

                                var modelDetail = model.ImportOrdersDetails;
                                int? parentIDmodel = db.ImportOrderDetails.Where(x => x.ParrentID == model.ID).Select(x => x.ParrentID).FirstOrDefault();
                                var modelDB = db.ImportOrderDetails.Where(x => x.IsActive == true && x.ParrentID == parentIDmodel);
                                var validmodelDB = modelDB.Count();
                                decimal InputNumber = 0;
                                decimal totaldetail = 0;
                                if (parentIDmodel != 0 && validmodelDB != 0)
                                {
                                    InputNumber = db.ImportOrderDetails.Where(x => x.IsActive == true && x.ParrentID == parentIDmodel).Sum(a => a.InputNumber);
                                    totaldetail = db.ImportOrderDetails.Where(x => x.IsActive == true && x.ParrentID == parentIDmodel).Sum(a => a.Money);
                                }

                                if (modelDetail != null)
                                {
                                    foreach (var item in modelDetail)
                                    {
                                        var importOrderDetail = new ImportOrderDetail
                                        {
                                            ID = item.ID,
                                            ProductID = item.ProductID,
                                            StationID = item.StationID,
                                            InputNumber = item.InputNumber,
                                            InputPrice = item.InputPrice,
                                            Money = item.Money,
                                            Date = model.Date,
                                            ParrentID = model.ID,
                                            SupplierID = model.SupplierID,
                                            ModifiedAt = DateTime.Now,
                                            ModifiedBy = currentUser.UserId,
                                        };
                                        if (item.ID != 0)
                                        {
                                            listedit.Add(importOrderDetail);
                                        }
                                        else
                                        {
                                            listadd.Add(importOrderDetail);
                                        }
                                    }
                                }
                                if (listadd != null)
                                {
                                    foreach (var item in listedit)
                                    {
                                        var detailedit = db.ImportOrderDetails.Where(x => x.ID == item.ID).Select(x => x.Money).FirstOrDefault();
                                        var inputedit = db.ImportOrderDetails.Where(x => x.ID == item.ID).Select(x => x.InputNumber).FirstOrDefault();
                                        totaldetail += (item.Money - detailedit);
                                        InputNumber += (item.InputNumber - inputedit);
                                        db.ImportOrderDetails.Attach(item);
                                        db.Entry(item).Property(a => a.ID).IsModified = false;
                                        db.Entry(item).Property(a => a.ParrentID).IsModified = true;
                                        db.Entry(item).Property(a => a.Date).IsModified = true;
                                        db.Entry(item).Property(a => a.ProductID).IsModified = true;
                                        db.Entry(item).Property(a => a.StationID).IsModified = true;
                                        db.Entry(item).Property(a => a.InputNumber).IsModified = true;
                                        db.Entry(item).Property(a => a.InputPrice).IsModified = true;
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
                                        totaldetail -= item.Money;
                                        InputNumber -= item.InputNumber;
                                        var remove = db.ImportOrderDetails.FirstOrDefault(x => x.ID == item.ID);
                                        remove.IsActive = false;
                                    }
                                }
                                db.SaveChanges();
                                if (listadd != null)
                                {
                                    foreach (var item in listadd)
                                    {
                                        totaldetail += item.Money;
                                        InputNumber += item.InputNumber;
                                        AddImportOderDetail(item);
                                    }
                                }

                                ImportOrder importOrder = new ImportOrder
                                {
                                    ID = model.ID,
                                    SupplierID = model.SupplierID,
                                    Information = model.Information,
                                    InvoiceCode = model.InvoiceCode,
                                    StationID = model.StationID,
                                    TotalQuantity = InputNumber,
                                    TotalMoney = totaldetail,
                                    Date = model.Date,
                                };

                                db.ImportOrders.Attach(importOrder);
                                db.Entry(importOrder).Property(a => a.ID).IsModified = false;
                                db.Entry(importOrder).Property(a => a.StationID).IsModified = true;
                                db.Entry(importOrder).Property(a => a.Date).IsModified = true;
                                db.Entry(importOrder).Property(a => a.InvoiceCode).IsModified = true;
                                db.Entry(importOrder).Property(a => a.TotalQuantity).IsModified = true;
                                db.Entry(importOrder).Property(a => a.TotalMoney).IsModified = true;
                                db.Entry(importOrder).Property(a => a.SupplierID).IsModified = true;
                                db.Entry(importOrder).Property(a => a.Information).IsModified = true;
                                db.SaveChanges();
                                var newJson = model.ToJson();
                                LogSystem log = new LogSystem
                                {
                                    ActiveType = DataActionTypeConstant.UPDATE_SHOP_CATEGORY_ACTION,
                                    FunctionName = DataFunctionNameConstant.UPDATE_SHOP_CATEGORY_FUNCTION,
                                    DataTable = DataTableConstant.STATION,
                                    Information = string.Format("Trước khi thay đổi: {0}   Sau khi thay đổi: {1}", oldJson, newJson)
                                };

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
        public ActionResult ImportOrder_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<ImportOrder> models)
        {
            var importOrderChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var listremovedetail = db.ImportOrderDetails.Where(x => x.ParrentID == model.ID).ToList();
                foreach (var item in listremovedetail)
                {
                    item.IsActive = false;
                }
                var removingObjects = db.ImportOrders.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
            }

            var count = db.SaveChanges();

            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_IMPORT_ORDER_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_IMPORT_ORDER_FUNCTION,
                DataTable = DataTableConstant.IMPORT_ORDER,
                Information = importOrderChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.Count() == count);
        }

        public void AddImportOderDetail(ImportOrderDetail model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            ImportOrderDetail addModel = new ImportOrderDetail
            {
                ProductID = model.ProductID,
                ParrentID = model.ParrentID,
                SupplierID = model.SupplierID,
                InputNumber = model.InputNumber,
                InputPrice = model.InputPrice,
                Money = (model.InputPrice) * (model.InputNumber),
                CreatedAt = DateTime.Now,
                CreatedBy = currentUser.UserId,
                Date = model.Date,
                IsActive = true,
                StationID = model.StationID.HasValue ? model.StationID.Value : currentUser.StationID,
                ModifiedAt = DateTime.Now,
                ModifiedBy = currentUser.UserId,
            };
            db.ImportOrderDetails.Add(addModel);
            db.SaveChanges();
        }
        public JsonResult CheckInventoryProduct(CalculationCostPriceModel model)
        {
            decimal totalSaleAmount = 0;
            decimal totalAvailableQuantity = 0;

            var invoiceDetails = from ids in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive)
                                 join iv in db.Invoices on ids.ParrentID equals iv.ID
                                 where ids.IsActive && iv.IsActive && ids.ProductID == model.ProductID && ids.StationID == model.StationID
                                 select ids;

            if (invoiceDetails != null && invoiceDetails.Any())
            {
                totalSaleAmount = invoiceDetails.Sum(x => x.SaleAmount);
            }

            var importDetails = from ids in db.ImportOrderDetails
                                join iv in db.ImportOrders on ids.ParrentID equals iv.ID
                                where ids.IsActive && iv.IsActive && ids.ProductID == model.ProductID && ids.StationID == model.StationID
                                select ids;

            if (importDetails != null && importDetails.Any())
            {
                totalAvailableQuantity = importDetails.Sum(x => x.InputNumber);
            }

            var quantityLeft = totalAvailableQuantity  > totalSaleAmount ? totalAvailableQuantity  - totalSaleAmount : 0;

            return Json(quantityLeft, JsonRequestBehavior.AllowGet);
        }

        public JsonResult CheckInventoryStation(CheckInventoryModel model)
        {
            var CheckInventoryStation = from x in db.ImportOrderDetails
                                        where (x.IsActive == true && x.StationID == model.StationID)
                                        select x;
            return Json(CheckInventoryStation.ToList().Select(x => new
            {
                ID = 1,
                CheckInventoryStation = 1,
            }), JsonRequestBehavior.AllowGet);
        }
    }
}