using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Data.Entity;
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
    public class StationController : BaseController
    {
        // GET: Admin/Station
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
        public ActionResult Station_Read([DataSourceRequest] DataSourceRequest request)
        {
            var users = db.Stations.AsNoTracking()
                        .Where(x => x.IsActive == true)
                        .Select(x => new StationViewModel()
                        {
                            UserChange = x.UserChange,
                            ID = x.ID,
                            StationName = x.StationName,
                            StationCode = x.StationCode,
                            PositionNew = x.PositionNew,
                            PositionOld = x.PositionOld,
                            ModifiedAt = (DateTime)x.ModifiedAt
                        });
            return Json(users.ToDataSourceResult(request));
        }
                
        [AllowAnonymous]
        public JsonResult GetStation(string text)
        {
            var shop = from x in db.Stations.AsNoTracking()
                       where (x.IsActive == true)
                       select x;
            if (!string.IsNullOrEmpty(text))
            {
                shop = shop.Where(p => p.StationName.Contains(text) || p.StationCode.Contains(text));
            }

            return Json(shop.ToList().Select(x => new
            {
                ID = x.ID,
                StationID = x.ID,
                StationName = x.StationName,
                StationDisplayName = string.Format("{0} : {1}", x.StationCode, x.StationName)
            }), JsonRequestBehavior.AllowGet);
        }
        //kendoold
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] Station model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            var stationChangeJson = model.ToJson();

            if (ModelState.IsValid)
            {
                var temp = (from p in db.Set<Station>().AsNoTracking()
                            where (p.StationCode.Equals(model.StationCode, StringComparison.OrdinalIgnoreCase) && p.IsActive)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    ModelState.AddModelError("", WebResources.ShopCodeExists);
                    return View(model);
                }
                else
                {
                    model.IsActive = true;
                    model.CreatedBy = currentUser.UserId;
                    model.CreatedAt = DateTime.Now;
                    db.Set<Station>().Add(model);

                    db.SaveChanges();
                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.ADD_SHOP_CATEGORY_ACTION,
                        FunctionName = DataFunctionNameConstant.ADD_SHOP_CATEGORY_FUNCTION,
                        DataTable = DataTableConstant.STATION,
                        Information = stationChangeJson
                    };

                    AddLogSystem.AddLog(log);
                    ViewBag.StartupScript = "create_success();";
                    return View(model);
                }
            }
            else
            {
                return View(model);
            }
        }
        
        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult EditingStation_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<Station> models)
        {
            var stationChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.Stations.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_SHOP_CATEGORY_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_SHOP_CATEGORY_FUNCTION,
                DataTable = DataTableConstant.STATION,
                Information = stationChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.ToDataSourceResult(request, ModelState));
        }
    }
}