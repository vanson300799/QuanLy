using AutoMapper;
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
    public class RentController : Controller
    {
        // GET: Admin/Product
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
        public ActionResult Rent_Read([DataSourceRequest] DataSourceRequest request)
        {
            IEnumerable<Rent> users = db.Rents.Where(x => x.IsActive == true).ToList();
            List<Rent> listproduct = new List<Rent>();
            foreach (var item in users)
            {
                var product = new Rent
                {
                    ID = item.ID,
                    ProductCode = item.ProductCode,
                    ProductName = item.ProductName,
                    CompanyRent = item.CompanyRent,
                    CreatedAt = item.CreatedAt,
                    TimeRent = item.TimeRent,
                    Price = item.Price
                };
                listproduct.Add(product);
            }
            var temnp = users.ToList();
            return Json(listproduct.ToDataSourceResult(request));
        }

        [AllowAnonymous]
        public JsonResult GetProduct(string text)
        {
            var shop = from x in db.Rents.AsNoTracking()
                       where (x.IsActive == true)
                       select x;
            if (!string.IsNullOrEmpty(text))
            {
                shop = shop.Where(p => p.ProductName.Contains(text) || p.ProductCode.Contains(text));
            }

            return Json(shop.ToList().Select(x => new
            {
                ID = x.ID,
                ProductName = x.ProductName,
                ProductCode = x.ProductCode,
                ProductDisplayName = string.Format("{0} : {1}", x.ProductCode, x.ProductName)
            }), JsonRequestBehavior.AllowGet);
        }
        public ActionResult Add()
        {

            var model = new Rent();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] Rent viewModel)
        {
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                viewModel.IsActive = true;
                viewModel.CreatedBy = currentUser.UserId;
                viewModel.CreatedAt = DateTime.Now;
                db.Set<Rent>().Add(viewModel);
                db.SaveChanges();
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
            var model = new Rent();
            var product = db.Products.Where(x => x.ID == id).FirstOrDefault();
            var count = db.Rents.Where(x => x.ProductID == id && x.Status != 1).Select(x => x.Number).AsEnumerable();
            ViewBag.Count = (product.Number != null ? product.Number : 0) - (count != null ? count.Sum() : 0);
            model.ProductID = id;
            model.ProductName = product.ProductName;
            model.ProductCode = product.ProductCode;
            List<int> test = new List<int>();
            var sum = test.Sum();
            return View("Edit", model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit([Bind(Include = "")] Rent model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            var product = db.Products.Where(x => x.ID == model.ProductID).FirstOrDefault();
            ViewBag.Count = (product.Number != null ? product.Number : 0) - db.Rents.Where(x => x.ProductID == model.ProductID).Select(x => x.Number).Sum();
            if (ModelState.IsValid)
            {
                model.IsActive = true;
                model.CreatedBy = currentUser.UserId;
                model.CreatedAt = DateTime.Now;
                model.ModifiedAt = DateTime.Now;
                db.Set<Rent>().Add(model);
                db.SaveChanges();
                ViewBag.StartupScript = "edit_success();";
                return View(model);
            }
            else
            {
                return View(model);
            }
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult Rent_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<ProductViewModel> models)
        {
            var productChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.Products.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_SUPPLIER_CATEGORY_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_COMMODITY_CATEGORY_FUNCTION,
                DataTable = DataTableConstant.PRODUCT,
                Information = productChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.ToDataSourceResult(request));
        }
    }
}