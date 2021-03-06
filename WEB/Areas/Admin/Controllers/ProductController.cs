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
    public class ProductController : Controller
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
        public ActionResult Product_Read([DataSourceRequest] DataSourceRequest request)
        {
            var users = db.Products.AsNoTracking()
                        .Where(x => x.IsActive == true)
                        .Select(x => new ProductViewModel()
                        {
                            ID = x.ID,
                            ProductCode = x.ProductCode,
                            ProductName = x.ProductName,
                            Position = x.Position,
                            Information = x.Information,
                            ModifiedAt = (DateTime)x.ModifiedAt,
                            Price = x.Price,
                            Number = x.Number,
                            Rest = x.Number - (db.Rents.Where(y => y.ProductID == x.ID && y.Status != 1).Select(y => y.Number).Sum() ?? 0 )
                        }).ToList();
            List<ProductViewModel> listproduct = new List<ProductViewModel>();
            foreach (var item in users)
            {
                var product = new ProductViewModel
                {
                    ID = item.ID,
                    ProductCode = item.ProductCode,
                    ProductName = item.ProductName,
                    Information = item.Information,
                    ModifiedAt = item.ModifiedAt,
                    Position = item.Position,
                    Price = item.Price,
                    Number = item.Number,
                    Rest = item.Rest
                };
                listproduct.Add(product);
            }
            var temnp = users.ToList();
            return Json(listproduct.OrderByDescending(x=>x.Rest).ToDataSourceResult(request));
        }

        [AllowAnonymous]
        public JsonResult GetProduct(string text)
        {
            var shop = from x in db.Products.AsNoTracking()
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

            var model = new ProductViewModel();
            return View(model);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] ProductViewModel viewModel)
        {
            var productChange = viewModel.ToJson();
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                var temp = (from p in db.Set<Product>().AsNoTracking()
                            where (p.IsActive && p.ProductCode.Equals(viewModel.ProductCode, StringComparison.OrdinalIgnoreCase))
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    ModelState.AddModelError("", WebResources.CommodityIdExists);
                    return View(viewModel);
                }
                else
                {
                    var config = new MapperConfiguration(cfg => cfg.CreateMap<ProductViewModel, Product>());
                    IMapper iMapper = config.CreateMapper();
                    var model = iMapper.Map<Product>(viewModel);
                    model.IsActive = true;
                    model.CreatedBy = currentUser.UserId;
                    model.CreatedAt = DateTime.Now;
                    db.Set<Product>().Add(model);

                    db.SaveChanges();
                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.ADD_COMMODITY_CATEGORY_ACTION,
                        FunctionName = DataFunctionNameConstant.ADD_COMMODITY_CATEGORY_FUNCTION,
                        DataTable = DataTableConstant.PRODUCT,
                        Information = productChange
                    };

                    AddLogSystem.AddLog(log);
                    ViewBag.StartupScript = "create_success();";
                    return View(viewModel);
                }
            }
            else
            {
                return View(viewModel);
            }
        }
        public ActionResult Edit(int id)
        {
            var model = db.Set<Product>().Find(id);
            var config = new MapperConfiguration(cfg => cfg.CreateMap<Product, ProductViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<ProductViewModel>(model);
            if (model == null)
            {
                return HttpNotFound();
            }
            viewModel.ProductCode = model.ProductCode;
            return View("Edit", viewModel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit([Bind(Include = "")] ProductViewModel model)
        {
            var oldProduct = db.Products.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
            var productChange = new List<Product>();
            productChange.Add(oldProduct);
            var productChangeJson = productChange.ToJson();
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                var temp = (from p in db.Set<Product>().AsNoTracking()
                            where (p.ProductCode.Equals(model.ProductCode, StringComparison.OrdinalIgnoreCase) && p.IsActive && p.ProductCode != model.ProductCode)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    ModelState.AddModelError("", WebResources.CommodityIdExists);
                    return View(model);
                }
                else
                {
                    try
                    {

                        Station modelStation = new Station
                        {
                            PositionOld = oldProduct.Position,
                            PositionNew = model.Position,
                            StationCode = model.ProductCode,
                            StationName = model.ProductName,
                            IsActive = true,
                            ModifiedBy = currentUser.UserId,
                            ModifiedAt = DateTime.Now,
                            CreatedAt = DateTime.Now,
                            CreatedBy = currentUser.UserId,
                            UserChange = currentUser.FullName
                        };

                        if(modelStation.PositionNew != modelStation.PositionOld)
                        {
                            db.Set<Station>().Add(modelStation);
                        }

                        Product modelProduct = new Product
                        {
                            ID = model.ID,
                            Information = model.Information,
                            ProductCode = model.ProductCode,
                            ProductName = model.ProductName,
                            Position = model.Position,
                            ModifiedBy = currentUser.UserId,
                            ModifiedAt = DateTime.Now,
                            IsActive = true,
                            Price = model.Price,
                            Number = model.Number
                        };

                        db.Products.Attach(modelProduct);
                        db.Entry(modelProduct).Property(a => a.ProductCode).IsModified = true;
                        db.Entry(modelProduct).Property(a => a.ProductName).IsModified = true;
                        db.Entry(modelProduct).Property(a => a.Position).IsModified = true;
                        db.Entry(modelProduct).Property(a => a.Information).IsModified = true;
                        db.Entry(modelProduct).Property(a => a.ModifiedBy).IsModified = true;
                        db.Entry(modelProduct).Property(a => a.ModifiedAt).IsModified = true;
                        db.Entry(modelProduct).Property(a => a.Price).IsModified = true;
                        db.Entry(modelProduct).Property(a => a.Number).IsModified = true;
                        db.SaveChanges();
                        LogSystem log = new LogSystem
                        {
                            ActiveType = DataActionTypeConstant.UPDATE_SHOP_CATEGORY_ACTION,
                            FunctionName = DataFunctionNameConstant.UPDATE_SHOP_CATEGORY_FUNCTION,
                            DataTable = DataTableConstant.STATION,
                            Information = productChangeJson
                        };

                        AddLogSystem.AddLog(log);
                        productChange.Add(modelProduct);
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
        public ActionResult Product_Destroy([DataSourceRequest] DataSourceRequest request,
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