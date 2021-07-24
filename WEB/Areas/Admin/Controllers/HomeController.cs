using Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;

namespace WEB.Areas.Admin.Controllers
{
    [AdminAuthorize]
    public class HomeController : Controller
    {
        WebModels.WebContext db = new WebModels.WebContext();
        //
        // GET: /Admin/Home/

        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Loading()
        {                                                                                                                                                                                                                                                                              
            return View();
        }

        public ActionResult _ContentLeft()
        {
            var userId = UserInfoHelper.GetUserData().UserId;
            // join webmodule
            var result = from wm in db.WebModules
                         join awmr in db.AccessWebModuleRoles on wm.ID equals awmr.WebModuleID
                         join uir in db.UserInRoles on awmr.RoleId equals uir.RoleId
                         where wm.Status.HasValue && wm.Status.Value == 1 && wm.Order < 22
                         && uir.UserId == userId && (awmr.View.HasValue && awmr.View.Value)
                         select wm;
            var test = result.OrderBy(x => x.Order).ToList();
            var distinct = test.Distinct().ToList();
            return PartialView(distinct);
        }
        public ActionResult _ReportMenuLeft()
        {
            var userId = UserInfoHelper.GetUserData().UserId;
            // join webmodule
            var result = from wm in db.WebModules
                         join awmr in db.AccessWebModuleRoles on wm.ID equals awmr.WebModuleID
                         join uir in db.UserInRoles on awmr.RoleId equals uir.RoleId
                         where wm.Status.HasValue && wm.Status.Value == 1 && wm.Order > 21
                         && uir.UserId == userId && (awmr.View.HasValue && awmr.View.Value)
                         select wm;
            var test = result.OrderBy(x => x.Order).ToList();
            return PartialView(test);
        }

        public ActionResult _ContentUser()
        {
            var currentUser = UserInfoHelper.GetUserData();
            var nav = from u in db.UserProfiles.Where(x => x.UserId == currentUser.UserId)
                      join sc in db.Stations on u.StationID equals sc.ID into leftjoin
                      from lj in leftjoin.DefaultIfEmpty()
                      select new UserProfileViewModel
                      {
                          UserId = u.UserId,
                          StationName = lj != null ? lj.StationName : string.Empty,
                          Mobile = u.Mobile,
                          Email = u.Email,
                          FullName = u.FullName,
                          StaffCode = u.StaffCode,
                          UserName = u.UserName,
                          Avatar = u.Avatar
                      };

            return PartialView(nav);
        }
    }
}
