using AutoMapper;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Globalization;
using System.Data.SqlClient;
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
    public class PriceController : Controller
    {
        // GET: Admin/Price
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
        public ActionResult Price_Read([DataSourceRequest] DataSourceRequest request)
        {
            var customers = db.Customers.Where(x => x.IsActive == true).ToList();

            var price = from u in db.Prices.Where(x => x.IsActive)
                        join cc in db.Products on u.ProductID equals cc.ID into group1
                        from item1 in group1.DefaultIfEmpty()

                        join sc in db.Stations on u.StationID equals sc.ID into group2
                        from item2 in group2.DefaultIfEmpty()

                        join cp in db.CustomerPrices on u.ID equals cp.PriceID into group3
                        from item3 in group3.DefaultIfEmpty()
                        select new PriceViewModel
                        {
                            ID = u.ID,
                            TimeApply = (DateTime)u.TimeApply,
                            ProductName = item1.ProductName,
                            StationName = item2.StationName,
                            Prices = u.Prices,
                            Information = u.Information,
                            CustomerID = item3.CustomerID,
                        };

            var groupByPrice = price.ToList().GroupBy(x => x.ID).Select(y => new PriceViewModel()
            {
                ID = y.Key,
                TimeApply = y.FirstOrDefault().TimeApply,
                ProductName = y.FirstOrDefault().ProductName,
                StationName = y.FirstOrDefault().StationName,
                Prices = y.FirstOrDefault().Prices,
                Information = y.FirstOrDefault().Information,
                CustomerIDs = y.Select(z => z.CustomerID).ToList()
            }).ToList();

            groupByPrice.ForEach(x => x.Customers = customers.Where(y => x.CustomerIDs.Contains(y.ID)));

            return Json(groupByPrice.ToDataSourceResult(request));
        }

        //kendoold
        public ActionResult Add()
        {
            var model = new PriceViewModel();
            model.StringTimeApply = DateTime.Now.ToString("dd/MM/yyyy HH:mm");
            return View(model);
        }


        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] PriceViewModel model, int[] CustomerID)
        {
            var priceChangeJson = model.ToJson();
            if (!string.IsNullOrEmpty(model.StringTimeApply))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.TimeApply = DateTime.ParseExact(model.StringTimeApply, format, provider);
            }
            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                var price = new Price
                {
                    CreatedAt = DateTime.Now,
                    CreatedBy = currentUser.UserId,
                    IsActive = true,
                    Information = model.Information,
                    Prices = model.Prices ?? default(int),
                    StationID = model.StationID,
                    ProductID = model.ProductID ?? default(int),
                    TimeApply = model.TimeApply
                };

                db.Set<Price>().Add(price);

                db.SaveChanges();

                var priceID = db.Prices.OrderByDescending(x => x.ID).FirstOrDefault();

                if (CustomerID != null)
                {
                    foreach (var item in CustomerID)
                    {
                        var customerPrice = new CustomerPrice
                        {
                            CustomerID = item,
                            PriceID = priceID.ID
                        };
                        db.Set<CustomerPrice>().Add(customerPrice);
                    }
                    db.SaveChanges();
                }
                LogSystem log = new LogSystem
                {
                    ActiveType = DataActionTypeConstant.ADD_PRICE_ACTION,
                    FunctionName = DataFunctionNameConstant.ADD_PRICE_FUNCTION,
                    DataTable = DataTableConstant.PRICE,
                    Information = priceChangeJson
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
            var model = db.Set<Price>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            var config = new MapperConfiguration(cfg => cfg.CreateMap<Price, PriceViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<PriceViewModel>(model);

            viewModel.StringTimeApply = viewModel.TimeApply.ToString("dd/MM/yyyy HH:mm");

            var listCustomerID = db.CustomerPrices.Where(x => x.PriceID == id).ToList().Select(x => x.CustomerID.ToString());
            //List<int> lstCustomerId = new List<int>();
            //foreach (var item in listCustomerID)
            //{
            //    var customer = db.Customers.Where(x => x.ID == item).FirstOrDefault();
            //    lstCustomerId.Add(customer.CustomerName);
            //}
            ViewBag.Customers = listCustomerID;
            return View("Edit", viewModel);
        }

        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit([Bind(Include = "")] PriceViewModel model, int[] CustomerID)
        {
            var oldPrice = db.Prices.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();

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
                    var price = new Price
                    {
                        IsActive = true,
                        Information = model.Information,
                        ProductID = model.ProductID ?? default(int),
                        StationID = model.StationID,
                        Prices = model.Prices ?? default(int),
                        TimeApply = model.TimeApply,
                        ID = model.ID,
                        ModifiedAt = DateTime.Now,
                        ModifiedBy = currentUser.UserId
                    };
                    db.Prices.Attach(price);
                    db.Entry(price).Property(a => a.ID).IsModified = false;
                    db.Entry(price).Property(a => a.TimeApply).IsModified = true;
                    db.Entry(price).Property(a => a.Prices).IsModified = true;
                    db.Entry(price).Property(a => a.ProductID).IsModified = true;
                    db.Entry(price).Property(a => a.StationID).IsModified = true;
                    db.Entry(price).Property(a => a.Information).IsModified = true;
                    db.Entry(price).Property(a => a.ModifiedBy).IsModified = true;
                    db.Entry(price).Property(a => a.ModifiedAt).IsModified = true;
                    db.SaveChanges();

                    var newPrice = db.Prices.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
                    var priceChange = new List<Price>();
                    priceChange.Add(oldPrice);
                    priceChange.Add(newPrice);
                    var priceChangeJson = priceChange.ToJson();

                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.UPDATE_PRICE_ACTION,
                        FunctionName = DataFunctionNameConstant.UPDATE_PRICE_FUNCTION,
                        DataTable = DataTableConstant.PRICE,
                        Information = priceChangeJson
                    };

                    AddLogSystem.AddLog(log);

                    var deletes = db.CustomerPrices.Where(x => x.PriceID == model.ID).ToList();
                    foreach (var item in deletes)
                    {
                        db.Entry(item).State = EntityState.Deleted;
                        db.SaveChanges();
                    }
                    if (CustomerID != null)
                    {
                        foreach (var item in CustomerID)
                        {
                            var customerPrice = new CustomerPrice
                            {
                                CustomerID = item,
                                PriceID = model.ID
                            };
                            db.Set<CustomerPrice>().Add(customerPrice);
                        }
                    }
                    db.SaveChanges();

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
        public ActionResult Price_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<Price> models)
        {
            var priceChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.Prices.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_PRICE_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_PRICE_FUNCTION,
                DataTable = DataTableConstant.PRICE,
                Information = priceChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.ToDataSourceResult(request));
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult CalculationSaleAmount(CalculationCostPriceModel model)
        {
            var helper = new RecalculateHelper();
            var result = helper.GetCostPrice(db, model.ProductID, model.StationID, new InvoiceDetail()
            {
                ProductID = model.ProductID,
                StationID = model.StationID,
                SaleAmount = model.Amount
            });

            if (result.Sum(x => x.QuantityTaken) != 0)
            {
                var costPrice = result.Any() ? result.Sum(x => x.Price * x.QuantityTaken) / result.Sum(y => y.QuantityTaken) : 0;
                return Json(costPrice, JsonRequestBehavior.AllowGet);

            }
            else
            {
                var costPrice = 0;
                return Json(costPrice, JsonRequestBehavior.AllowGet);
            }
        }

        [AllowAnonymous]
        [HttpPost]
        public JsonResult CalculationFreightCharge(CalculateFreightChargeModel model)
        {
            var discount = model.ListPrice - ((decimal)1.1 * model.CostPrice);
            if (discount < 0)
            {
                discount = 0;
            }

            if (discount > 0)
            {
                var freightCharge = from x in db.DealDetails.Where(x => x.FreightCharges.IsActive)
                                    where (x.IsActive == true && x.StationID == model.StationId && x.DiscountAmount > discount)
                                    select new { FreightCharge = x.FreightCharge, Discount = x.DiscountAmount };
                var result = freightCharge.OrderBy(x => x.Discount).FirstOrDefault();

                return Json(result != null ? result.FreightCharge : 0, JsonRequestBehavior.AllowGet);
            }

            return Json(0, JsonRequestBehavior.AllowGet);
        }

        //private List<CostPriceResultModel> GetCostPrice(List<ImportOrderDetailState> lstState, InvoiceDetail invoiceDetail)
        //{
        //    var result = new List<CostPriceResultModel>();
        //    var quantityLeft = invoiceDetail.SaleAmount;
        //    var allImportOrders = lstState.Where(x =>
        //    x.ImportOrderDetail.ProductID == invoiceDetail.ProductID
        //    && x.ImportOrderDetail.StationID == invoiceDetail.StationID && x.QuantityLeft > 0);
        //    foreach (var item in allImportOrders)
        //    {
        //        if (item.QuantityLeft >= invoiceDetail.SaleAmount)
        //        {
        //            result.Add(new CostPriceResultModel()
        //            {
        //                ImportOrderId = item.ImportOrderDetail.ID,
        //                Price = item.ImportOrderDetail.InputPrice,
        //                QuantityTaken = invoiceDetail.SaleAmount
        //            });
        //            item.QuantityLeft -= invoiceDetail.SaleAmount;
        //            break;
        //        }
        //        else
        //        {
        //            result.Add(new CostPriceResultModel()
        //            {
        //                ImportOrderId = item.ImportOrderDetail.ID,
        //                Price = item.ImportOrderDetail.InputPrice,
        //                QuantityTaken = item.QuantityLeft
        //            });

        //            invoiceDetail.SaleAmount = invoiceDetail.SaleAmount - item.QuantityLeft;
        //            item.QuantityLeft = 0;
        //        }
        //    }

        //    return result;
        //}

        [AllowAnonymous]
        public JsonResult GetPrice(int id)
        {
            var Price = from x in db.Prices
                        where (x.IsActive == true && x.ProductID == id)
                        select x;
            var listcheck = Price.ToList().Count();
            if (listcheck == 0)
            {
                var PriceNull = from x in db.Prices
                                where (x.IsActive == true && x.ProductID == 1)
                                select x;
                return Json(PriceNull.ToList().Select(x => new
                {
                    ID = 1,
                    Price = 0,
                }), JsonRequestBehavior.AllowGet);

            }
            return Json(Price.ToList().Select(x => new
            {
                ID = x.ID,
                Price = x.Prices,
            }), JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        public JsonResult GetPriceListed(int id)
        {
            var ListPrice = from x in db.ListedPrices
                            where (x.IsActive == true && x.ProductID == id)
                            select x;
            var listcheck = ListPrice.ToList().Count();
            if (listcheck == 0)
            {
                var ListPriceNull = from x in db.Prices
                                    where (x.IsActive == true && x.ProductID == 1)
                                    select x;
                return Json(ListPriceNull.ToList().Select(x => new
                {
                    ID = 1,
                    Price = 0,
                }), JsonRequestBehavior.AllowGet);

            }
            return Json(ListPrice.ToList().Select(x => new
            {
                ID = x.ID,
                Price = x.PriceListed,
            }), JsonRequestBehavior.AllowGet);
        }
    }
}