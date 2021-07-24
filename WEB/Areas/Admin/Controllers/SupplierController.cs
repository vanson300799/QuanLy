using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;
using WebModels.Constants;

namespace WEB.Areas.Admin.Controllers
{
    [PetroAuthorizeAttribute]
    public class SupplierController : Controller
    {
        // GET: Admin/Supplier
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
        public ActionResult Supplier_Read([DataSourceRequest] DataSourceRequest request)
        {
            var users = db.Suppliers.AsNoTracking()
                        .Where(x => x.IsActive == true)
                        .Select(x => new SupplierViewModel()
                        {
                            ID = x.ID,
                            SupplierCode = x.SupplierCode,
                            SupplierName = x.SupplierName,
                            TaxCode = x.TaxCode,
                            SupplierAddress = x.SupplierAddress,
                            PhoneNumber = x.PhoneNumber,
                            Information = x.Information,
                            ModifiedAt = (DateTime)x.ModifiedAt,
                            CreatedAt = (DateTime)x.CreatedAt
                        });
            return Json(users.ToDataSourceResult(request));
        }
        [AllowAnonymous]
        public JsonResult GetSupplier(string text)
        {
            var shop = from x in db.Suppliers.AsNoTracking()
                       where (x.IsActive == true)
                       select x;
            if (!string.IsNullOrEmpty(text))
            {
                shop = shop.Where(p => p.SupplierName.Contains(text) || p.SupplierCode.Contains(text));
            }

            return Json(shop.ToList().Select(x => new
            {
                ID = x.ID,
                SupplierID = x.ID,
                SupplierName = x.SupplierName,
                SupplierDisplayName = string.Format("{0} : {1}", x.SupplierCode, x.SupplierName)
            }), JsonRequestBehavior.AllowGet);
        }
        //kendoOld
        public ActionResult Add()
        {

            var model = new Supplier();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] Supplier model)
        {
            var supplierChangeJson = model.ToJson();
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {

                model.IsActive = true;
                model.CreatedBy = currentUser.UserId;
                model.CreatedAt = DateTime.Now;
                model.PhoneNumber = currentUser.FullName;
                db.Set<Supplier>().Add(model);

                db.SaveChanges();
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.ADD_SUPPLIER_CATEGORY_ACTION,
                    FunctionName = DataFunctionNameConstant.ADD_SUPPLIER_CATEGORY_FUNCTION,
                    DataTable = DataTableConstant.SUPPLIER,
                    Information = supplierChangeJson
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
            var model = db.Set<Supplier>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            model.CurrentCode = model.SupplierCode;
            return View("Edit", model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit([Bind(Include = "")] Supplier model)
        {
            var oldSupplier = db.Suppliers.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
            var supplierChange = new List<Supplier>();
            supplierChange.Add(oldSupplier);
            supplierChange.Add(model);
            var supplierChangeJson = supplierChange.ToJson();
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                var temp = (from p in db.Set<Supplier>().AsNoTracking()
                            where (p.IsActive && p.SupplierCode.Equals(model.SupplierCode, StringComparison.OrdinalIgnoreCase) && p.SupplierCode != model.CurrentCode)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    ModelState.AddModelError("", WebResources.SupplierIdExists);
                    return View(model);
                }
                else
                {
                    try
                    {
                        model.ModifiedBy = currentUser.UserId;
                        model.ModifiedAt = DateTime.Now;
                        db.Suppliers.Attach(model);
                        db.Entry(model).Property(a => a.SupplierCode).IsModified = true;
                        db.Entry(model).Property(a => a.SupplierName).IsModified = true;
                        db.Entry(model).Property(a => a.TaxCode).IsModified = true;
                        db.Entry(model).Property(a => a.SupplierAddress).IsModified = true;
                        db.Entry(model).Property(a => a.Information).IsModified = true;
                        db.Entry(model).Property(a => a.ModifiedBy).IsModified = true;
                        db.Entry(model).Property(a => a.ModifiedAt).IsModified = true;
                        db.SaveChanges();
                        LogSystem log = new LogSystem
                        {
                            ActiveType = DataActionTypeConstant.UPDATE_SUPPLIER_CATEGORY_ACTION,
                            FunctionName = DataFunctionNameConstant.UPDATE_SUPPLIER_CATEGORY_FUNCTION,
                            DataTable = DataTableConstant.SUPPLIER,
                            Information = supplierChangeJson
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
            }
            else
            {
                return View(model);
            }
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Supplier_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<Supplier> models)
        {
            var supplierChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.Suppliers.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_SUPPLIER_CATEGORY_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_SUPPLIER_CATEGORY_FUNCTION,
                DataTable = DataTableConstant.SUPPLIER,
                Information = supplierChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.ToDataSourceResult(request, ModelState));
        }
    }
}