using System;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;
using WebModels.Constants;
using AutoMapper;
using System.Data.Entity;
using System.Globalization;

namespace WEB.Areas.Admin.Controllers
{
    [PetroAuthorizeAttribute]
    public class FreightChagesController : Controller
    {
        // GET: Admin/FreightChages

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

        [AllowAnonymous]
        public JsonResult GetFreightCharges(int id)
        {
            var FreightCharge = from x in db.DealDetails
                            where (x.IsActive && x.FreightCharges.IsActive && x.StationID == id)
                            select x;
            var listcheck = FreightCharge.ToList().Count();
            if (listcheck == 0)
            {
                var FreightChargeNull = from x in db.Prices
                                    where (x.IsActive == true && x.StationID == 13)
                                    select x;
                return Json(FreightChargeNull.ToList().Select(x => new
                {
                    ID = 1,
                    FreightCharges = 0,
                }), JsonRequestBehavior.AllowGet);

            }
            return Json(FreightCharge.ToList().Select(x => new
            {
                ID = x.ID,
                FreightCharges = x.FreightCharge,
            }), JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        public ActionResult FreightCharges_Read([DataSourceRequest] DataSourceRequest request)
        {
            var currentUser = UserInfoHelper.GetUserData();
            var price = from fp in db.FreightCharges.Where(x => x.IsActive && (!currentUser.StationID.HasValue || x.StationID == currentUser.StationID))
                        join sc in db.Stations on fp.StationID equals sc.ID
                        select new FreightChageViewModel
                        {
                            ID = fp.ID,
                            TimeApply = (DateTime)fp.TimeApply,
                            Information = fp.Information,
                            StationName = sc.StationName,
                            StationCode = sc.StationCode,
                            IsLock = fp.IsLock
                        };
            return Json(price.ToDataSourceResult(request));
        }
        public JsonResult Read_ByParent(int? id)
        {

            var dealDetail = from e in db.DealDetails
                             where (e.IsActive && e.FreightCharges.IsActive && id.HasValue ? e.ParentID == id : (e.ParentID == null))
                             select new DealDetailViewModels
                             {
                                 ID = e.ID,
                                 Description = e.Description,
                                 DiscountAmount = e.DiscountAmount,
                                 FreightCharge = e.FreightCharge
                             };
            return Json(dealDetail.ToList(), JsonRequestBehavior.AllowGet);
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult FreightCharges_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<FreightCharge> models)
        {
            var freightChargesChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.FreightCharges.FirstOrDefault(x => x.ID == model.ID);
                var dealDetail = db.DealDetails.Where(x => x.ParentID == model.ID).ToList();
                foreach (var item in dealDetail)
                {
                    item.IsActive = false;
                }
                db.SaveChanges();
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_FREIGHTCHAGES_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_FREIGHTCHAGES_FUNCTION,
                DataTable = DataTableConstant.FREIGHT,
                Information = freightChargesChangeJson
            };

            AddLogSystem.AddLog(log);
            ViewBag.StartupScript = "refresh_detail();";

            return Json(models.ToDataSourceResult(request));
        }

        public ActionResult RecordLock(int id)
        {
            var removingObjects = db.FreightCharges.FirstOrDefault(x => x.ID == id);
            var freightChargesChangeJson = removingObjects.ToJson();
            removingObjects.IsLock = !removingObjects.IsLock;
            ViewBag.status = removingObjects.IsLock;
            db.SaveChanges();
            if (removingObjects.IsLock == true) {
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.BLOCK_FREIGHTCHAGES_ACTION,
                    FunctionName = DataFunctionNameConstant.BLOCK_FREIGHTCHAGES_FUNCTION,
                    DataTable = DataTableConstant.FREIGHT,
                    Information = freightChargesChangeJson
                };
                AddLogSystem.AddLog(log);
            }
            else
            {
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.UNBLOCK_FREIGHTCHAGES_ACTION,
                    FunctionName = DataFunctionNameConstant.UNBLOCK_FREIGHTCHAGES_FUNCTION,
                    DataTable = DataTableConstant.FREIGHT,
                    Information = freightChargesChangeJson
                };
                AddLogSystem.AddLog(log);
            }

            return Json(new { ErrorMessage = string.Empty, currentIsLock = removingObjects.IsLock, ID = id }, JsonRequestBehavior.AllowGet);
        }

        // delete deal detail (table child)

        public ActionResult Add()
        {
            var notbookey = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            ViewBag.notbookDate = notbookey.DateTimeKey.Value;
            var model = new FreightChageViewModel();
            model.DealDetails = db.DealDetails.Where(x => x.ParentID == null);
            model.StringTimeApply = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
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
        public ActionResult Add(FreightChageViewModel model)
        {
            var freightChageChangeJson = model.ToJson();
            var currentUser = UserInfoHelper.GetUserData();

            if (!string.IsNullOrEmpty(model.StringTimeApply))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.TimeApply = DateTime.ParseExact(model.StringTimeApply, format, provider);
            }

            var notbookDate = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            if (model.TimeApply < notbookDate.DateTimeKey.Value)
            {
                return Json(new { message = "Ngày khóa sổ nằm trong phạm vi tính toán! Vui lòng lựa chọn lại" }, JsonRequestBehavior.AllowGet);
            }
            if (ModelState.IsValid)
            {
                FreightCharge freightCharge = new FreightCharge
                {
                    CreatedAt = DateTime.Now,
                    CreatedBy = currentUser.UserId,
                    ModifiedAt = DateTime.Now,
                    ModifiedBy = currentUser.UserId,
                    StationID = model.StationID,
                    Information = model.Information,
                    TimeApply = model.TimeApply,
                    IsActive = true,
                    IsLock = false
                };

                db.FreightCharges.Add(freightCharge);

                db.SaveChanges();
                var modelDeal = model.DealDetails;
                var parrentID = db.FreightCharges.OrderByDescending(x => x.ID).FirstOrDefault();

                List<DealDetail> list = new List<DealDetail>();

                if (modelDeal != null)
                {
                    foreach (var item in modelDeal)
                    {
                        var deal = new DealDetail()
                        {
                            FreightCharge = item.FreightCharge,
                            ParentID = parrentID.ID,
                            Description = item.Description,
                            DiscountAmount = item.DiscountAmount,
                            StationID = parrentID.StationID
                        };
                        AddDealDetail(deal);
                    }
                }

                db.SaveChanges();
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.ADD_FREIGHTCHAGES_ACTION,
                    FunctionName = DataFunctionNameConstant.ADD_FREIGHTCHAGES_FUNCTION,
                    DataTable = DataTableConstant.FREIGHT,
                    Information = freightChageChangeJson
                };

                AddLogSystem.AddLog(log);

                return View(model);

            }
            else
            {
                return View(model);
            }
        }

        public ActionResult DealDetail()
        {
            return PartialView("DealDetail");
        }

        protected void AddDealDetail(DealDetail model)
        {

            DealDetail addModel = new DealDetail();
            var currentUser = UserInfoHelper.GetUserData();
            addModel.CreatedAt = DateTime.Now;
            addModel.CreatedBy = currentUser.UserId;
            addModel.Date = DateTime.Now;
            addModel.Description = model.Description;
            addModel.DiscountAmount = model.DiscountAmount;
            addModel.FreightCharge = model.FreightCharge;
            addModel.IsActive = true;
            addModel.ParentID = model.ParentID;
            addModel.ModifiedAt = DateTime.Now;
            addModel.ModifiedBy = currentUser.UserId;
            addModel.StationID = model.StationID;
            db.DealDetails.Add(addModel);
        }
        public ActionResult Edit(int id)
        {
            var notbookey = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            ViewBag.notbookDate = notbookey.DateTimeKey.Value;
            var model = db.Set<FreightCharge>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }

            var viewModel = GetFreightChageViewModel(model, id);
            viewModel.StringTimeApply = viewModel.TimeApply.ToString("dd/MM/yyyy HH:mm");
            return View("Edit", viewModel);
        }
        private FreightChageViewModel GetFreightChageViewModel(FreightCharge model, int id)
        {
            var config = new MapperConfiguration(cfg => cfg.CreateMap<FreightCharge, FreightChageViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<FreightChageViewModel>(model);

            viewModel.DealDetails = db.DealDetails.Where(x => x.IsActive && x.FreightCharges.IsActive && x.ParentID == model.ID).ToList();
            var shopname = db.Stations.Where(x => x.ID == viewModel.StationID).AsNoTracking().FirstOrDefault();
            viewModel.StationName = shopname.StationName;

            return viewModel;
        }
       
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(FreightChageViewModel model)
        {
            if (!string.IsNullOrEmpty(model.StringTimeApply))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.TimeApply = DateTime.ParseExact(model.StringTimeApply, format, provider);
            }

            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                try
                {
                    using (DbContextTransaction transaction = db.Database.BeginTransaction())
                    {
                        try
                        {
                            // save main model
                            FreightCharge freightCharge = new FreightCharge
                            {
                                ID = model.ID,
                                Information = model.Information,
                                ModifiedBy = currentUser.UserId,
                                ModifiedAt = DateTime.Now,
                                TimeApply = model.TimeApply,
                                StationID = model.StationID
                            };
                            db.FreightCharges.Attach(freightCharge);
                            db.Entry(freightCharge).Property(a => a.ID).IsModified = false;
                            db.Entry(freightCharge).Property(a => a.Information).IsModified = true;
                            db.Entry(freightCharge).Property(a => a.ModifiedBy).IsModified = true;
                            db.Entry(freightCharge).Property(a => a.ModifiedAt).IsModified = true;
                            db.Entry(freightCharge).Property(a => a.TimeApply).IsModified = true;
                            db.Entry(freightCharge).Property(a => a.StationID).IsModified = true;
                            db.SaveChanges();

                            // save detail models
                            var modelDeal = model.DealDetails;
                            var modelDB = db.DealDetails.Where(x => x.ParentID == model.ID && x.IsActive == true);

                            List<DealDetail> list = new List<DealDetail>();
                            List<DealDetail> listDelete = new List<DealDetail>();
                            List<DealDetail> listAdd = new List<DealDetail>();

                            if (modelDeal != null)
                            {
                                foreach (var item in modelDeal)
                                {
                                    var dealDetial = new DealDetail
                                    {
                                        Description = item.Description,
                                        DiscountAmount = item.DiscountAmount,
                                        FreightCharge = item.FreightCharge,
                                        ModifiedAt = DateTime.Now,
                                        ModifiedBy = currentUser.UserId,
                                        StationID = model.StationID,
                                        ID = item.ID,
                                        ParentID = model.ID,
                                    };

                                    if (item.ID != 0)
                                    {
                                        list.Add(dealDetial);
                                    }
                                    else
                                    {
                                        listAdd.Add(dealDetial);
                                    }
                                }
                            }
                            else
                            {
                                foreach (var item in modelDB)
                                {
                                    listDelete.Add(item);
                                }
                            }
                            if (listAdd != null)
                            {
                                foreach (var item in list)
                                {
                                    db.DealDetails.Attach(item);
                                    db.Entry(item).Property(a => a.ID).IsModified = false;
                                    db.Entry(item).Property(a => a.Description).IsModified = true;
                                    db.Entry(item).Property(a => a.DiscountAmount).IsModified = true;
                                    db.Entry(item).Property(a => a.FreightCharge).IsModified = true;
                                    db.Entry(item).Property(a => a.StationID).IsModified = true;
                                    db.Entry(item).Property(a => a.ModifiedAt).IsModified = true;
                                    db.Entry(item).Property(a => a.ModifiedBy).IsModified = true;
                                    db.Entry(item).Property(a => a.ParentID).IsModified = true;
                                }
                            }

                            if (listAdd != null)
                            {
                                foreach (var item in listAdd)
                                {
                                    AddDealDetail(item);
                                }
                            }

                            foreach (var itemDB in modelDB)
                            {
                                bool checkDelete = true;
                                foreach (var item in list)
                                {
                                    if (itemDB.ID == item.ID)
                                    {
                                        checkDelete = false;
                                        break;
                                    }
                                }
                                if (checkDelete == true)
                                {
                                    listDelete.Add(itemDB);
                                }

                            }

                            if (listDelete != null)
                            {
                                foreach (var item in listDelete)
                                {
                                    var remove = db.DealDetails.FirstOrDefault(x => x.ID == item.ID);
                                    remove.IsActive = false;
                                }
                            }
                            db.SaveChanges();

                            LogSystem log = new LogSystem
                            {
                                ActiveType = DataActionTypeConstant.UPDATE_FREIGHTCHAGES_ACTION,
                                FunctionName = DataFunctionNameConstant.UPDATE_FREIGHTCHAGES_FUNCTION,
                                DataTable = DataTableConstant.FREIGHT
                            };

                            AddLogSystem.AddLog(log);

                            transaction.Commit();
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
            else
            {
                return View(model);
            }
        }
    }
}