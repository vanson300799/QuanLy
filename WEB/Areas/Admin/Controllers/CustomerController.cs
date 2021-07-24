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
    public class CustomerController : BaseController
    {
        // GET: Admin/Customer
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
        public ActionResult Customer_Read([DataSourceRequest] DataSourceRequest request)
        {
            var users = db.Customers.AsNoTracking()
                        .Where(x => x.IsActive == true)
                        .Select(x => new CustomerViewModel()
                        {
                            ID = x.ID,
                            CustomerCode = x.CustomerCode,
                            CustomerName = x.CustomerName,
                            TaxCode = x.TaxCode,
                            CustomerAddress = x.CustomerAddress,
                            PhoneNumber = x.PhoneNumber,
                            Information = x.Information,
                            ModifiedAt = (DateTime)x.ModifiedAt
                        });
            return Json(users.ToDataSourceResult(request));
        }

        [AllowAnonymous]
        public JsonResult GetCustomer(string text)
        {
            var shop = from x in db.Customers.AsNoTracking()
                       where (x.IsActive == true)
                       select x;
            if (!string.IsNullOrEmpty(text))
            {
                shop = shop.Where(p => p.CustomerName.Contains(text) || p.CustomerCode.Contains(text));
            }
            return Json(shop.ToList().Select(x => new
            {
                ID = x.ID,
                CustomerCode = x.CustomerCode,
                CustomerName = x.CustomerName,
                CustomerDisplayName = string.Format("{0} : {1}", x.CustomerCode, x.CustomerName)
            }), JsonRequestBehavior.AllowGet);
        }
        //kendoold
        public ActionResult Add()
        {

            var model = new Customer();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] Customer model)
        {
            var customerChangeJson = model.ToJson();
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                var temp = (from p in db.Set<Customer>().AsNoTracking()
                            where (p.IsActive&&p.CustomerCode.Equals(model.CustomerCode, StringComparison.OrdinalIgnoreCase))
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    ModelState.AddModelError("", WebResources.CustomerIdExists);
                    return View(model);
                }
                else
                {
                    model.IsActive = true;
                    model.CreatedBy = currentUser.UserId;
                    model.CreatedAt = DateTime.Now;
                    db.Set<Customer>().Add(model);

                    db.SaveChanges();
                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.ADD_CUSTOMER_CATEGORY_ACTION,
                        FunctionName = DataFunctionNameConstant.ADD_CUSTOMER_CATEGORY_FUNCTION,
                        DataTable = DataTableConstant.CUSTOMER,
                        Information = customerChangeJson
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
            var model = db.Set<Customer>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            model.CurrentCode = model.CustomerCode;
            return View("Edit", model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit([Bind(Include = "")] Customer model)
        {
            var oldCustomer = db.Customers.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
            var customerChange = new List<Customer>();
            customerChange.Add(oldCustomer);
            customerChange.Add(model);
            var customerChangeJson = customerChange.ToJson();
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                var temp = (from p in db.Set<Customer>().AsNoTracking()
                            where (p.CustomerCode.Equals(model.CustomerCode, StringComparison.OrdinalIgnoreCase)&&p.IsActive && p.CustomerCode != model.CurrentCode)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    ModelState.AddModelError("", WebResources.CustomerIdExists);
                    return View(model);
                }
                else
                {
                    try
                    {
                        model.ModifiedBy = currentUser.UserId;
                        model.ModifiedAt = DateTime.Now;
                        db.Customers.Attach(model);
                        db.Entry(model).Property(a => a.CustomerCode).IsModified = true;
                        db.Entry(model).Property(a => a.CustomerName).IsModified = true;
                        db.Entry(model).Property(a => a.TaxCode).IsModified = true;
                        db.Entry(model).Property(a => a.CustomerAddress).IsModified = true;
                        db.Entry(model).Property(a => a.PhoneNumber).IsModified = true;
                        db.Entry(model).Property(a => a.Information).IsModified = true;
                        db.Entry(model).Property(a => a.ModifiedBy).IsModified = true;
                        db.Entry(model).Property(a => a.ModifiedAt).IsModified = true;
                        db.SaveChanges();
                        LogSystem log = new LogSystem
                        {
                            ActiveType = DataActionTypeConstant.UPDATE_CUSTOMER_CATEGORY_ACTION,
                            FunctionName = DataFunctionNameConstant.UPDATE_CUSTOMER_CATEGORY_FUNCTION,
                            DataTable = DataTableConstant.CUSTOMER,
                            Information = customerChangeJson
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
        public ActionResult Customer_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<Customer> models)
        {
            var customerChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.Customers.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_CUSTOMER_CATEGORY_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_CUSTOMER_CATEGORY_FUNCTION,
                DataTable = DataTableConstant.STATION,
                Information = customerChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.ToDataSourceResult(request, ModelState));
        }
    }
}