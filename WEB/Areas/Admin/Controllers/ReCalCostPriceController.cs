using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;
using WebModels.Constants;

namespace WEB.Areas.Admin.Controllers
{
    public class ReCalCostPriceController : Controller
    {
        WebContext db = new WebContext();
        // GET: Admin/ReCalCostPrice
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        [Obsolete]
        public ActionResult Index(ReCalCostPriceViewModel model)
        {   
            var currentUser = UserInfoHelper.GetUserData();

            var helper = new RecalculateHelper();
            var stationId = model.StationID != 0 ? model.StationID : currentUser.StationID;
            var oldReCalCostPrice = helper.GetRecalculateCostPrice(db, stationId);
            var oldJson = oldReCalCostPrice.ToJson();
            helper.RecalculateCostPrice(db, stationId);
            var newReCalCostPrice = helper.GetRecalculateCostPrice(db, stationId);
            var newJson = newReCalCostPrice.ToJson();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.UPDATE_COSTMANAGE_ACTION,
                FunctionName = DataFunctionNameConstant.RECAL_COST_PRICE_FUNCTION,
                DataTable = DataTableConstant.RECALCOSTPRICE,
                Information = string.Format("Tính lại giá vốn \\nTrước khi thay đổi: {0} Sau khi thay đổi: {1}", oldJson, newJson)
            };
            AddLogSystem.AddLog(log);

            var detail = from bd in db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive 
                         && x.InvoiceDetail.Invoice.IsActive
                         && (model.StationID == 0 || x.StationID == model.StationID))
                         join iv in db.Invoices on bd.ParrentID equals iv.ID
                         join pd in db.Products on bd.ProductID equals pd.ID into group3
                         from item3 in group3.DefaultIfEmpty()
                         where iv.IsActive
                         select new InvoiceDetailViewModel
                         {
                             ID = bd.ID,
                             Date = (DateTime)bd.Date,
                             ProductID = bd.ProductID,
                             ProductCode = item3.ProductCode,
                             ProductName = item3.ProductName,
                             SaleAmount = bd.SaleAmount,
                             CostPrice = bd.CostPrice,
                             SalePrice = bd.SalePrice,
                             ListPrice = bd.ListPrice,
                             SupplierDiscount = bd.SupplierDiscount,
                             FreightCharge = bd.FreightCharge,
                             InvoiceType = bd.InvoiceType,
                             Money = bd.Money,
                             CustomerPayment = bd.CustomerPayment,
                             InvoiceCode = iv.InvoiceCode
                         };
            return Json(detail.ToList(), JsonRequestBehavior.AllowGet);
        }
    }
}