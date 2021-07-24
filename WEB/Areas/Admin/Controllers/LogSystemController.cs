using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Linq;
using System.Web.Mvc;
using WEB.Models;
using WebModels;

namespace WEB.Areas.Admin.Controllers
{
    public class LogSystemController : Controller
    {
        // GET: Admin/LogSystem

        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        [AllowAnonymous]
        public ActionResult LogSystem_Read([DataSourceRequest] DataSourceRequest request)
        {
            var logSystem = from u in db.LogSystems
                        join cc in db.UserProfiles on u.UserID equals cc.UserId into group1

                        from item in group1.DefaultIfEmpty()
                        select new LogSystemViewModel
                        {
                            ID = u.ID,
                            CreatedAt = (DateTime)u.CreatedAt,
                            CreatedBy = u.CreatedBy,
                            ActiveType = u.ActiveType,
                            DataTable = u.DataTable,
                            FunctionName = u.FunctionName,
                            Information = u.Information,
                            UserName = item.UserName
                        };
            return Json(logSystem.ToDataSourceResult(request));
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Detail(int id)
        {
            var noteDetail = db.LogSystems.FirstOrDefault(x => x.ID == id);
            return View(noteDetail);
        }
    }
}