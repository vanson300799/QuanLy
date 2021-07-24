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
    public class ListedPriceController : Controller
    {
        // GET: Admin/ListedPrice
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
        public ActionResult ListedPrice_Read([DataSourceRequest] DataSourceRequest request)
        {
            var price = from u in db.ListedPrices.Where(x => x.IsActive == true)
                        join sc in db.Products on u.ProductID equals sc.ID into leftjoin
                        from lj in leftjoin.DefaultIfEmpty()
                        select new ListedPriceViewModel
                        {
                            ID = u.ID,
                            TimeApply = (DateTime)u.TimeApply,
                            ProductName = lj != null ? lj.ProductName : string.Empty,
                            PriceListed = u.PriceListed,
                            Information = u.Information
                        };
            return Json(price.ToDataSourceResult(request));
        }
        //kendoold
        public ActionResult Add()
        {

            var model = new ListedPriceViewModel();
            model.StringTimeApply = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] ListedPriceViewModel model)
        {
            var listedPriceChangeJson = model.ToJson();
            if (!string.IsNullOrEmpty(model.StringTimeApply))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.TimeApply = DateTime.ParseExact(model.StringTimeApply, format, provider);
            }
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {

                var listedPrice = new ListedPrice
                {
                    CreatedAt = DateTime.Now,
                    CreatedBy = currentUser.UserId,
                    IsActive = true,
                    Information = model.Information,
                    ProductID = model.ProductID ?? default(int),
                    PriceListed = model.PriceListed ?? default(int),
                    TimeApply = model.TimeApply
                };

                db.Set<ListedPrice>().Add(listedPrice);

                db.SaveChanges();
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.ADD_LIST_PRICE_ACTION,
                    FunctionName = DataFunctionNameConstant.ADD_LIST_PRICE_FUNCTION,
                    DataTable = DataTableConstant.LIST_PRICE,
                    Information = listedPriceChangeJson
                };

                AddLogSystem.AddLog(log);
                ViewBag.StartupScript = "create_success();";
                return View(model);

            }
            else
            {
                return View(model);
            }
        }
        public ActionResult Edit(int id)
        {
            var model = db.Set<ListedPrice>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            var config = new MapperConfiguration(cfg => cfg.CreateMap<ListedPrice, ListedPriceViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<ListedPriceViewModel>(model);

            viewModel.StringTimeApply = viewModel.TimeApply.ToString("dd/MM/yyyy HH:mm");
            return View("Edit", viewModel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit([Bind(Include = "")] ListedPriceViewModel model)
        {
            var oldListedPrice = db.ListedPrices.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
            var listedPriceChange = new List<ListedPrice>();
            listedPriceChange.Add(oldListedPrice);

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
                    var listedPrice = new ListedPrice
                    {
                        IsActive = true,
                        Information = model.Information,
                        ProductID = model.ProductID ?? default(int),
                        PriceListed = model.PriceListed ?? default(int),
                        TimeApply = model.TimeApply,
                        ID = model.ID,
                        ModifiedAt = DateTime.Now,
                        ModifiedBy = currentUser.UserId
                    };

                    db.ListedPrices.Attach(listedPrice);
                    db.Entry(listedPrice).Property(a => a.ID).IsModified = false;
                    db.Entry(listedPrice).Property(a => a.TimeApply).IsModified = true;
                    db.Entry(listedPrice).Property(a => a.PriceListed).IsModified = true;
                    db.Entry(listedPrice).Property(a => a.ProductID).IsModified = true;
                    db.Entry(listedPrice).Property(a => a.Information).IsModified = true;
                    db.Entry(listedPrice).Property(a => a.ModifiedBy).IsModified = true;
                    db.Entry(listedPrice).Property(a => a.ModifiedAt).IsModified = true;
                    db.SaveChanges();

                    var newListedPrice = db.ListedPrices.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
                    listedPriceChange.Add(newListedPrice);
                    var listedPriceChangeJson = listedPriceChange.ToJson();
                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.UPDATE_LIST_PRICE_ACTION,
                        FunctionName = DataFunctionNameConstant.UPDATE_LIST_PRICE_FUNCTION,
                        DataTable = DataTableConstant.LIST_PRICE,
                        Information = listedPriceChangeJson
                    };

                    AddLogSystem.AddLog(log);
                    ViewBag.StartupScript = "edit_success();";
                    return View(model);

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

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult ListedPrice_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<ListedPrice> models)
        {
            var listedPriceChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.ListedPrices.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_LIST_PRICE_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_LIST_PRICE_FUNCTION,
                DataTable = DataTableConstant.LIST_PRICE,
                Information = listedPriceChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.ToDataSourceResult(request));
        }
    }
}