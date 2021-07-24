using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using OfficeOpenXml;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web.Hosting;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;
using WebModels.Constants;

namespace WEB.Areas.Admin.Controllers
{
    public class RevenueRecalculationController : Controller
    {
        WebContext db = new WebContext();

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        // GET: Admin/RevenueRecalculation
        public ActionResult Index()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Index(ReCalculateRevenueViewModel model)
        {
            var notbookDate = db.NoteBookKeys.Where(x => x.IsActive).FirstOrDefault();
            if (model.Year <= notbookDate.DateTimeKey.Value.Year && model.Month < notbookDate.DateTimeKey.Value.Month)
            {
                return Json(new { message = "Ngày khóa sổ nằm trong phạm vi tính toán! Vui lòng lựa chọn lại" }, JsonRequestBehavior.AllowGet);
            }

            if (model.Year < notbookDate.DateTimeKey.Value.Year)
            {
                return Json(new { message = "Ngày khóa sổ nằm trong phạm vi tính toán! Vui lòng lựa chọn lại" }, JsonRequestBehavior.AllowGet);
            }

            var currentUser = UserInfoHelper.GetUserData();
            var invoiceManages = db.InvoiceManages.Where(x => (model.StationID == 0 || x.StationID == model.StationID) && x.IsActive && x.Date.Year == model.Year && x.Date.Month == model.Month);
            var invoiceManageDetails = db.InvoiceManageDetails.Where(x => (model.StationID == 0 || x.StationID == model.StationID) && x.IsActive && x.Date.Year == model.Year && x.Date.Month == model.Month);
            var invoiceInMonth = db.Invoices.Where(x => (model.StationID == 0 || x.StationID == model.StationID) && x.IsActive && (!currentUser.StationID.HasValue || currentUser.StationID == 0 || x.StationID == currentUser.StationID) &&
                        x.Date.Month == model.Month && x.Date.Year == model.Year).ToList();
            var invoiceInMonthIds = invoiceInMonth.Select(x => x.ID);
            var invoiceDetals = db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive && invoiceInMonthIds.Contains(x.ParrentID));
            var dictionary = invoiceDetals.GroupBy(y => y.ProductID).ToDictionary(x => x.Key, x => x.Sum(z => z.SaleAmount));
            var oldJson = invoiceInMonth.ToJson();

            if (invoiceInMonth.Count == 0)
            {
                return null;
            }

            invoiceInMonth.ForEach(x => x.TotalRevenue = 0);

            var invoiceIds = invoiceInMonth.Select(x => x.ID);
            var invoiceDetailInMonth = db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive && x.InvoiceDetail.Invoice.IsActive && invoiceIds.Contains(x.ParrentID)).ToList();

            var helper = new RecalculateHelper();
            helper.CaculateInvoiceRevenue(invoiceManageDetails.ToList(), invoiceDetailInMonth);

            db.SaveChanges();

            var invoiceInMonthNew = db.Invoices.Where(x => (model.StationID == 0 || x.StationID == model.StationID) && x.IsActive && (!currentUser.StationID.HasValue || currentUser.StationID == 0 || x.StationID == currentUser.StationID) &&
            x.Date.Month == model.Month && x.Date.Year == model.Year).ToList();
            var newJson = invoiceInMonthNew.ToJson();

            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.REVENUE_RECALCULATION_ACTION,
                FunctionName = DataFunctionNameConstant.REVENUE_RECALCULATION_FUNCTION,
                DataTable = DataTableConstant.REVENUERE_CALCULATION,
                Information = string.Format("Tính lại doanh thu hóa đơn {0}-{1}   Trước khi thay đổi: {2} Sau khi thay đổi: {3}", model.Month, model.Year, oldJson, newJson)
            };

            AddLogSystem.AddLog(log);

            var price = from sb in db.Invoices.Where(x => x.IsActive && (model.StationID == 0 || x.StationID == model.StationID) &&
                        x.Date.Month == model.Month && x.Date.Year == model.Year)
                        join sc in db.Stations on sb.StationID equals sc.ID
                        join cum in db.Customers on sb.CustomerID equals cum.ID
                        select new InvoiceIndexViewModel
                        {
                            ID = sb.ID,
                            Date = (DateTime)sb.Date,
                            InvoiceCode = sb.InvoiceCode,
                            CustomerID = sb.CustomerID,
                            CustomerName = cum.CustomerName,
                            StationID = sb.StationID,
                            StationName = sc.StationName,
                            Note = sb.Note,
                            Vehicle = sb.Vehicle,
                            TotalQuantity = sb.TotalQuantity,
                            TotalFreightCharge = sb.TotalFreightCharge,
                            TotalDiscount = sb.TotalDiscount,
                            TotalMoney = sb.TotalMoney,
                            CustomerPayment = sb.CustomerPayment,
                            IsLock = sb.IsLock,
                            TotalRevenue = sb.TotalRevenue
                        };
            return Json(price.OrderBy(x => x.Date), JsonRequestBehavior.AllowGet);
        }

    }
}