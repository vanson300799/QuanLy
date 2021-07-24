using Kendo.Mvc.UI;
using Kendo.Mvc.Extensions;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebModels;
using System.IO;
using WebMatrix.WebData;
using System.Web.Security;
using System.Data;
using WEB.Models;
using WEB.WebHelpers;
using WebModels.Constants;
using System.Data.Entity;

namespace WEB.Areas.Admin.Controllers
{
    [PetroAuthorizeAttribute]
    public class UserController : BaseController
    {
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
        public ActionResult Users_Read([DataSourceRequest] DataSourceRequest request)
        {
            var users = from u in db.UserProfiles.Where(x => x.IsActive)
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
            List<UserProfileViewModel> listuser = new List<UserProfileViewModel>();
            foreach (var item in users)
            {
                var getRole = Roles.GetRolesForUser(item.UserName).ToArray();
                var stringRole = String.Join(", " , getRole);
                UserProfileViewModel user = new UserProfileViewModel()
                {
                    UserId = item.UserId,
                    StationName = item.StationName,
                    Mobile = item.Mobile,
                    Email = item.Email,
                    FullName = item.FullName,
                    StaffCode = item.StaffCode,
                    UserName = item.UserName,
                    Avatar = item.Avatar,
                    Role = stringRole
                };
                listuser.Add(user);
            }
            return Json(listuser.ToDataSourceResult(request));
        }

        public ActionResult Add()
        {
            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Add([Bind(Exclude = "")] RegisterModel model, string[] roles, HttpPostedFileBase image)
        {
            var currentUser = UserInfoHelper.GetUserData();
            ModelState.Remove("UserProfile.UserName");
            model.UserProfile.UserName = model.UserName;
            model.UserProfile.CreatedBy = currentUser.UserId;
            model.UserProfile.CreatedAt = DateTime.Now;
            var userChange = new List<RegisterModel>();
            userChange.Add(model);
            var userChangeJson = userChange.ToJson();
            if (ModelState.IsValid)
            {

                var temp = (from p in db.Set<UserProfile>().AsNoTracking()
                            where (p.UserName.Equals(model.UserName, StringComparison.OrdinalIgnoreCase)&&p.IsActive)
                            select p).FirstOrDefault();
                var temp1 = (from p in db.Set<UserProfile>().AsNoTracking()
                             where (p.StaffCode.Equals(model.UserProfile.StaffCode, StringComparison.OrdinalIgnoreCase) && p.IsActive)
                             select p).FirstOrDefault();
                if (temp1 != null)
                {
                    ModelState.AddModelError("", AccountResources.StaffCodeExists);
                    return View(model);
                }
                else if (temp != null)
                {
                    ModelState.AddModelError("", AccountResources.UserNameExists);
                    return View(model);
                }
                else
                {
                    if (image != null)
                    {
                        var name = image.FileName;
                        string extension = Path.GetExtension(name);
                        var newName = model.UserName + extension;
                        var dir = new System.IO.DirectoryInfo(Server.MapPath("/content/uploads/avatars/"));
                        if (!dir.Exists) dir.Create();
                        var uri = "/content/uploads/avatars/" + newName;
                        image.SaveAs(HttpContext.Server.MapPath(uri));
                        try
                        {
                            if (ImageTools.ValidateImage(System.Web.HttpContext.Current.Server.MapPath(uri)))
                            {
                                var result = ImageTools.ResizeImage(Server.MapPath(uri), Server.MapPath(uri), 240, 240, true, 80);
                                model.UserProfile.Avatar = uri;
                            }
                            else
                            {
                                Utility.DeleteFile(uri);
                            }
                        }
                        catch (Exception)
                        { }
                    }

                    WebSecurity.CreateUserAndAccount(model.UserName, model.Password, new
                    {
                        model.UserProfile.StationID,
                        model.UserProfile.IsActive,
                        model.UserProfile.StaffCode,
                        model.UserProfile.FullName,
                        model.UserProfile.Email,
                        model.UserProfile.Mobile,
                        model.UserProfile.Avatar,
                        model.UserProfile.CreatedBy,
                        model.UserProfile.CreatedAt
                    });

                    try
                    {
                        Roles.AddUserToRoles(model.UserName, roles);
                    }
                    catch (Exception)
                    { }
                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.ADD_USER_ACTION,
                        FunctionName = DataFunctionNameConstant.ADD_USER_FUNCTION,
                        DataTable = DataTableConstant.USER_PROFILE,
                        Information = userChangeJson
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

        public ActionResult Edit(int id)
        {

            var user = db.Set<UserProfile>().Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            user.CurrentName = user.UserName;
            user.CurrentCode = user.StaffCode;
            ViewBag.Roles = Roles.GetRolesForUser(user.UserName).ToList();
            return View("Edit", user);

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "")] UserProfile model, string[] roles, HttpPostedFileBase image)
        {
            var currentUser = UserInfoHelper.GetUserData();
            var userOld = db.UserProfiles.Where(x => x.StaffCode == model.StaffCode).AsNoTracking().FirstOrDefault();
            var userChange = new List<UserProfile>();
            userChange.Add(userOld);
            userChange.Add(model);
            var userChangeJson = userChange.ToJson();
            if (ModelState.IsValid)
            {
                ViewBag.Roles = roles;
                var delavatar = false;
                var temp1 = (from p in db.Set<UserProfile>().AsNoTracking()
                             where (p.StaffCode.Equals(model.StaffCode, StringComparison.OrdinalIgnoreCase) &&p.IsActive && (p.StaffCode != model.CurrentCode))
                             select p).FirstOrDefault();
                if (temp1 != null)
                {
                    ModelState.AddModelError("", AccountResources.StaffCodeExists);
                    return View(model);
                }
                else
                {
                    if (image != null)
                    {
                        var name = image.FileName;
                        string extension = Path.GetExtension(name);
                        var newName = model.UserName + extension;
                        var dir = new System.IO.DirectoryInfo(Server.MapPath("/content/uploads/avatars/"));
                        if (!dir.Exists) dir.Create();
                        var uri = "/content/uploads/avatars/" + newName;
                        image.SaveAs(HttpContext.Server.MapPath(uri));
                        try
                        {
                            if (ImageTools.ValidateImage(System.Web.HttpContext.Current.Server.MapPath(uri)))
                            {
                                var result = ImageTools.ResizeImage(Server.MapPath(uri), Server.MapPath(uri), 240, 240, true, 80);
                                model.Avatar = uri;
                            }
                            else
                            {
                                Utility.DeleteFile(uri);
                                model.Avatar = null;
                            }
                        }
                        catch (Exception)
                        { }
                    }
                    else
                    {
                        if (model.Avatar == null)
                        {
                            delavatar = true;
                        }
                    }

                    db.UserProfiles.Attach(model);
                    db.Entry(model).Property(a => a.StaffCode).IsModified = true;
                    db.Entry(model).Property(a => a.StationID).IsModified = true;
                    db.Entry(model).Property(a => a.UserName).IsModified = true;
                    db.Entry(model).Property(a => a.FullName).IsModified = true;
                    db.Entry(model).Property(a => a.Email).IsModified = true;
                    db.Entry(model).Property(a => a.Mobile).IsModified = true;
                    db.Entry(model).Property(a => a.IsActive).IsModified = true;
                    //db.Entry(model).Property(a => a.ModifiedBy).IsModified = true;
                    //db.Entry(model).Property(a => a.ModifiedAt).IsModified = true;
                    db.Entry(model).Property(a => a.Avatar).IsModified = (model.Avatar != null) || delavatar;
                    db.SaveChanges();
                    try
                    {
                        foreach (var role in Roles.GetRolesForUser(model.UserName))
                        {
                            Roles.RemoveUserFromRole(model.UserName, role);
                        }
                        Roles.AddUserToRoles(model.UserName, roles);
                    }
                    catch (Exception)
                    { }
                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.UPDATE_USER_ACTION,
                        FunctionName = DataFunctionNameConstant.UPDATE_USER_FUNCTION,
                        DataTable = DataTableConstant.USER_PROFILE,
                        Information = userChangeJson
                    };

                    AddLogSystem.AddLog(log);
                    ViewBag.StartupScript = "edit_success();";
                    return View(model);
                }

            }
            else
            {
                return View(model);
            }
        }

        public ActionResult Delete(int id)
        {

            var user = db.Set<UserProfile>().Find(id);
            if (user == null)
            {
                return HttpNotFound();
            }
            return View("Delete", user);

        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Delete(UserProfile model)
        {
            var userOld = db.UserProfiles.Where(x => x.UserId == model.UserId).AsNoTracking().FirstOrDefault();
            var userChange = new List<UserProfile>();
            userChange.Add(userOld);
            var userChangeJson = userChange.ToJson();


            try
            {
                ((SimpleMembershipProvider)Membership.Provider).DeleteUser(model.UserName, true);
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.DELETE_USER_ACTION,
                    FunctionName = DataFunctionNameConstant.DELETE_USER_FUNCTION,
                    DataTable = DataTableConstant.USER_PROFILE,
                    Information = userChangeJson
                };

                AddLogSystem.AddLog(log);
                ViewBag.StartupScript = "delete_success();";
                return View();
            }
            catch (Exception ex)
            {

                ModelState.AddModelError("", ex.Message);
                return View(model);
            }

        }

        public ActionResult Deletes(string id)
        {

            var objects = id.Split(',');
            var lstUserId = new List<int>();
            foreach (var obj in objects)
            {
                try
                {
                    lstUserId.Add(int.Parse(obj.ToString()));
                }
                catch (Exception)
                { }
            }

            var temp = from p in db.Set<UserProfile>()
                       where lstUserId.Contains(p.UserId)
                       select p;

            return View(temp.ToList());

        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Deletes(List<UserProfile> model)
        {

            var temp = new List<UserProfile>();
            foreach (var item in model)
            {
                try
                {
                    ((SimpleMembershipProvider)Membership.Provider).DeleteUser(item.UserName, true);
                    db.SaveChanges();

                }
                catch (Exception)
                {
                    temp.Add(item);
                }
            }

            if (temp.Count == 0)
            {
                ViewBag.StartupScript = "deletes_success();";
                return View(temp);
            }
            else if (temp.Count > 0)
            {
                ViewBag.StartupScript = "top.$('#grid').data('kendoGrid').dataSource.read();";
                ModelState.AddModelError("", Resources.Common.ErrorDeleteItems);
                return View(temp);
            }
            else
            {
                //LogSystem log = new LogSystem
                //{
                //    ActiveType = DataActionTypeConstant.DELETE_USER_ACTION,
                //    FunctionName = DataFunctionNameConstant.DELETE_USER_FUNCTION,
                //    DataTable = DataTableConstant.USER_PROFILE
                //};

                //AddLogSystem.AddLog(log);
                ViewBag.StartupScript = "deletes_success();";
                return View();
            }

        }

        public ActionResult ChangePassword(string userName)
        {
            if (!WebSecurity.UserExists(userName))
            {
                return HttpNotFound();
            }

            ViewBag.UserName = userName;

            return View();
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult ChangePassword(LocalPasswordModel model, string userName)
        {
            var userChangeJson = userName.ToJson();
            bool changePasswordSucceeded;

            try
            {
                string token = WebSecurity.GeneratePasswordResetToken(userName, 30);
                changePasswordSucceeded = WebSecurity.ResetPassword(token, model.NewPassword);
            }
            catch (Exception)
            {
                changePasswordSucceeded = false;
            }

            if (changePasswordSucceeded)
            {
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.CHANGE_PASSWORD_USER_ACTION,
                    FunctionName = DataFunctionNameConstant.CHANGE_PASSWORD_FUNCTION,
                    DataTable = DataTableConstant.USER_PROFILE,
                    Information = userChangeJson
                };


                AddLogSystem.AddLog(log);
                ViewBag.StartupScript = "change_success();";
            }
            else
            {
                ModelState.AddModelError("", "The current password is incorrect or the new password is invalid.");
            }

            return View();
        }

        //public ActionResult AdminSitesMapping(int id)
        //{
        //    var user = db.UserProfiles.Find(id);
        //    if (user == null)
        //        return HttpNotFound();
        //    var temp = user.AccessAdminSites.Select(x => x.AdminSite).Select(x => new { ID = x.ID }).ToArray();
        //    string[] accesses = temp.Count() > 0 ? new string[temp.Count()] : new string[0];
        //    for (int i = 0; i < temp.Count(); i++)
        //        accesses[i] = temp[i].ID.ToString();
        //    ViewBag.Tree = GetAdminSitesTree();
        //    ViewBag.UserId = id;
        //    return View(accesses);
        //}

        //[HttpPost]
        //[ValidateAntiForgeryToken]
        //public ActionResult AdminSitesMapping(int id, string[] checkedNodes)
        //{
        //    var user = db.UserProfiles.Find(id);
        //    if (user == null)
        //        return HttpNotFound();
        //    List<int> lstSiteID = new List<int>();
        //    try
        //    {
        //        using (var ts = new TransactionScope())
        //        {
        //            if (checkedNodes != null && checkedNodes.Count() > 0)
        //                foreach (var x in checkedNodes)
        //                    lstSiteID.Add(int.Parse(x));
        //            user.AccessAdminSites.Clear();
        //            if (lstSiteID.Count > 0)
        //                foreach (var x in lstSiteID)
        //                    user.AccessAdminSites.Add(new AccessAdminSite() { AdminSiteID = x });
        //            db.SaveChanges();
        //            ts.Complete();
        //            ViewBag.StartupScript = "create_success();";

        //            // clear cache
        //            var sessionKey = "AdminSite-" + Culture + "-" + HttpContext.User.Identity.Name;
        //            Session[sessionKey] = null;

        //            return View();
        //        }
        //    }
        //    catch (Exception ex)
        //    {
        //        ModelState.AddModelError("", ex.Message);
        //        var temp = user.AccessAdminSites.Select(x => x.AdminSite).Select(x => new { ID = x.ID }).ToArray();
        //        string[] accesses = temp.Count() > 0 ? new string[temp.Count()] : new string[0];
        //        for (int i = 0; i < temp.Count(); i++)
        //            accesses[i] = temp[i].ID.ToString();
        //        ViewBag.Tree = GetAdminSitesTree();
        //        ViewBag.UserId = id;
        //        return View(accesses);
        //    }
        //}

        //public JsonResult GetAccessAdminSites(int? id)
        //{
        //    var adminSites = from e in db.AdminSites.AsNoTracking()
        //                     where (id.HasValue ? e.ParentID == id : e.ParentID == null)
        //                     select new
        //                     {
        //                         id = e.ID,
        //                         Name = e.Title,
        //                         hasChildren = e.SubAdminSites.Any()
        //                     };
        //    return Json(adminSites, JsonRequestBehavior.AllowGet);
        //}

        //private IEnumerable<TreeViewItemModel> GetAdminSitesTree()
        //{
        //    List<TreeViewItemModel> tree = new List<TreeViewItemModel>();
        //    var roots = db.AdminSites.AsNoTracking().Where(x => x.ParentID == null).AsEnumerable();
        //    if (roots.Count() > 0)
        //        foreach (var item in roots)
        //        {
        //            TreeViewItemModel node = new TreeViewItemModel();
        //            node.Id = item.ID.ToString();
        //            node.Text = item.Title;
        //            node.HasChildren = item.SubAdminSites.Any();
        //            if (node.HasChildren)
        //                SubAdminSitesTree(ref node, ref tree);
        //            tree.Add(node);
        //        }
        //    return tree;
        //}

        private void SubAdminSitesTree(ref TreeViewItemModel parentNode, ref List<TreeViewItemModel> tree)
        {
            int parentID = int.Parse(parentNode.Id);
            var nodes = db.AdminSites.AsNoTracking().Where(x => x.ParentID == parentID).AsEnumerable();
            foreach (var item in nodes)
            {
                TreeViewItemModel node = new TreeViewItemModel();
                node.Id = item.ID.ToString();
                node.Text = item.Title;
                node.HasChildren = item.SubAdminSites.Any();
                parentNode.Items.Add(node);
                if (node.HasChildren)
                    SubAdminSitesTree(ref node, ref tree);
            }
        }

        //public ActionResult ModulesMapping(int id)
        //{
        //    ViewBag.UserId = id;
        //    return View();
        //}

        //[HttpGet]
        //public JsonResult GetModulesPermissions(int id)
        //{
        //    var user = db.UserProfiles.Find(id);
        //    if (user == null)
        //        return Json(null);
        //    var modulesPermissions = user.AccessWebModules
        //        .Select(x =>
        //            new
        //            {
        //                WebModuleID = x.WebModuleID,
        //                View = x.View,
        //                Add = x.Add,
        //                Edit = x.Edit,
        //                Delete = x.Delete
        //            });
        //    return Json(modulesPermissions, JsonRequestBehavior.AllowGet);
        //}

        //[HttpPost]
        //public JsonResult UpdateModulePerm(AccessWebModule data)
        //{

        //    if (ModelState.IsValid)
        //    {
        //        var item = db.AccessWebModules.AsNoTracking().SingleOrDefault(x => x.UserId == data.UserId && x.WebModuleID == data.WebModuleID);
        //        if (item != null)
        //        {
        //            db.Entry(item).State = System.Data.Entity.EntityState.Detached;
        //            db.AccessWebModules.Attach(data);
        //            db.Entry(data).Property(x => x.View).IsModified = true;
        //            db.Entry(data).Property(x => x.Add).IsModified = true;
        //            db.Entry(data).Property(x => x.Edit).IsModified = true;
        //            db.Entry(data).Property(x => x.Delete).IsModified = true;
        //            db.SaveChanges();
        //        }
        //        else
        //        {
        //            db.AccessWebModules.Add(data);
        //            db.SaveChanges();
        //        }
        //        return Json(new { success = true });
        //    }
        //    return Json(new { success = false });
        //}
    }
}
