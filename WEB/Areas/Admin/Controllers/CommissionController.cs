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
    public class CommissionController : Controller
    {
        // GET: Admin/Commission
        WebContext db = new WebContext();

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        public ActionResult Index()
        {
            return View();
        }
        [AllowAnonymous]
        public ActionResult Commission_Read([DataSourceRequest] DataSourceRequest request)
        {
            var price = from u in db.Commissions.Where(x => x.IsActive)                    
                        join sc in db.Stations on u.StationID equals sc.ID into group1

                        from item1 in group1.DefaultIfEmpty()
                        join ctc in db.Customers on u.CustomerID equals ctc.ID into group2

                        from item2 in group2.DefaultIfEmpty()
                        select new CommissionViewModel
                        {
                            ID = u.ID,
                            TimeApply = (DateTime)u.TimeApply,
                            StationName = item1.StationName,
                            CustomerName = item2.CustomerName,
                            Commission = (decimal)u.CommissionRate,
                            Information = u.Information,
                            Vehicle = u.Vehicle
                        };
            
            return Json(price.ToDataSourceResult(request));
        }
        //kendoold
        public ActionResult Add()
        {
            var viewModel = new CommissionViewModel();
            viewModel.StringTimeApply = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
            return View(viewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] CommissionViewModel viewModel)
        {
            if (!string.IsNullOrEmpty(viewModel.StringTimeApply))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                viewModel.TimeApply = DateTime.ParseExact(viewModel.StringTimeApply, format, provider);
            }
            var commissionChangeJson = viewModel.ToJson();
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                viewModel.IsActive = true;
                viewModel.CreatedAt = DateTime.Now;
                viewModel.CreatedBy = currentUser.UserId;
                var config = new MapperConfiguration(cfg => cfg.CreateMap<CommissionViewModel, Commission>());
                IMapper iMapper = config.CreateMapper();
                var model = iMapper.Map<Commission>(viewModel);

                db.Set<Commission>().Add(model);

                db.SaveChanges();
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.ADD_COMMISSION_ACTION,
                    FunctionName = DataFunctionNameConstant.ADD_COMMISSION_FUNCTION,
                    DataTable = DataTableConstant.COMMISSION,
                    Information = commissionChangeJson
                };

                AddLogSystem.AddLog(log);
                ViewBag.StartupScript = "create_success();";
                return View(viewModel);
            }
            else
            {
                return View(viewModel);
            }
        }

        public ActionResult Edit(int id)
        {
            var model = db.Set<Commission>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            var config = new MapperConfiguration(cfg => cfg.CreateMap<Commission, CommissionViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<CommissionViewModel>(model);

            viewModel.StringTimeApply = viewModel.TimeApply.ToString("dd/MM/yyyy HH:mm");
            return View("Edit", viewModel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit([Bind(Include = "")] CommissionViewModel viewModel)
        {
            var oldCommission = db.Commissions.Where(x => x.ID == viewModel.ID).AsNoTracking().FirstOrDefault();
            var commissionChange = new List<Commission>();
                commissionChange.Add(oldCommission);

            var commissionChangeJson = commissionChange.ToJson();
            if (!string.IsNullOrEmpty(viewModel.StringTimeApply))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                viewModel.TimeApply = DateTime.ParseExact(viewModel.StringTimeApply, format, provider);
            }
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                try
                {
                    viewModel.ModifiedBy = currentUser.UserId;
                    viewModel.ModifiedAt = DateTime.Now;
                    var config = new MapperConfiguration(cfg => cfg.CreateMap<CommissionViewModel, Commission>());
                    IMapper iMapper = config.CreateMapper();
                    var model = iMapper.Map<Commission>(viewModel);
                    db.Commissions.Attach(model);
                    db.Entry(model).Property(a => a.TimeApply).IsModified = true;
                    db.Entry(model).Property(a => a.CommissionRate).IsModified = true;
                    db.Entry(model).Property(a => a.StationID).IsModified = true;
                    db.Entry(model).Property(a => a.CustomerID).IsModified = true;
                    db.Entry(model).Property(a => a.Information).IsModified = true;
                    db.Entry(model).Property(a => a.ModifiedBy).IsModified = true;
                    db.Entry(model).Property(a => a.ModifiedAt).IsModified = true;
                    db.Entry(model).Property(a => a.Vehicle).IsModified = true;
                    db.SaveChanges();
                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.UPDATE_COMMISSION_ACTION,
                        FunctionName = DataFunctionNameConstant.UPDATE_COMMISSION_FUNCTION,
                        DataTable = DataTableConstant.COMMISSION,
                        Information = commissionChangeJson
                    };
                    commissionChange.Add(model);
                    AddLogSystem.AddLog(log);
                    ViewBag.StartupScript = "edit_success();";
                    return View(viewModel);

                }
                catch (Exception ex)
                {
                    ModelState.AddModelError("", ex.Message);
                    return View(viewModel);
                }
            }
            else
            {
                return View(viewModel);
            }
        }
        
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Commission_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<Commission> models)
        {
            var commissionChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.Commissions.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_COMMISSION_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_COMMISSION_FUNCTION,
                DataTable = DataTableConstant.COMMISSION,
                Information = commissionChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.ToDataSourceResult(request));
        }
    }
}