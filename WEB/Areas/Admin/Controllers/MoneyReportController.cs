using Common;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web.Hosting;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;

namespace WEB.Areas.Admin.Controllers
{
    public class MoneyReportController : Controller
    {
        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        // GET: Admin/DetailImport
        public ActionResult Index()
        {
            var model = new MoneyReportViewModel();
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID;
            }
            return View(model);
        }
        [AllowAnonymous]
        public ActionResult MoneyReport_Read([DataSourceRequest] DataSourceRequest request, MoneyReportViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);

            var import = from bd in db.InvoiceDetails.Where(x => x.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID )
                         &&( x.InvoiceType == "Tiền mặt" || x.InvoiceType == "Nợ tiền mặt")
                         && EntityFunctions.TruncateTime(x.Date) <= EntityFunctions.TruncateTime(end) && EntityFunctions.TruncateTime(x.Date) >= EntityFunctions.TruncateTime(start))
                         join ct in db.Customers on bd.Invoice.CustomerID equals ct.ID into group1

                         from item1 in group1.DefaultIfEmpty()
                         select new MoneyReportViewModel
                         {
                             DateTime = (DateTime)bd.Date,
                             CustomerName = item1.CustomerName,
                             Vehicle = bd.Invoice.Vehicle,
                             Amount = bd.Invoice.TotalQuantity ?? default,
                             Money = bd.Invoice.TotalMoney ?? default,
                             CustomerPayment = bd.Invoice.CustomerPayment ?? default,
                             Debt = (bd.Invoice.TotalMoney - bd.Invoice.CustomerPayment) ??default,
                             Note = bd.Invoice.Note
                         };


            var countlist = 1;
            List<MoneyReportViewModel> importlist = new List<MoneyReportViewModel>();

            foreach (var item in import)
            {
                MoneyReportViewModel list = new MoneyReportViewModel
                {
                    Count = countlist,
                    DateTime = item.DateTime,
                    CustomerName = item.CustomerName,
                    Vehicle = item.Vehicle,
                    Amount = item.Amount,
                    Money = item.Money,
                    CustomerPayment = item.CustomerPayment,
                    Debt = item.Debt,
                    Note = item.Note,
                };
                countlist += 1;
                importlist.Add(list);
            }
            return Json(importlist, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(MoneyReportViewModel model)
        {
            var result = DownloadCostIncurred(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Bao_cao_tien_mat.xlsx");
        }
        public byte[] DownloadCostIncurred(MoneyReportViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);

            var import = from bd in db.InvoiceDetails.Where(x => x.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                         && (x.InvoiceType == "Tiền mặt" || x.InvoiceType == "Nợ tiền mặt")
                         && EntityFunctions.TruncateTime(x.Date) <= EntityFunctions.TruncateTime(end) && EntityFunctions.TruncateTime(x.Date) >= EntityFunctions.TruncateTime(start))
                         join ct in db.Customers on bd.Invoice.CustomerID equals ct.ID into group1

                         from item1 in group1.DefaultIfEmpty()
                         select new MoneyReportViewModel
                         {
                             DateTime = (DateTime)bd.Date,
                             CustomerName = item1.CustomerName,
                             Vehicle = bd.Invoice.Vehicle,
                             Amount = bd.Invoice.TotalQuantity ?? default,
                             Money = bd.Invoice.TotalMoney ?? default,
                             CustomerPayment = bd.Invoice.CustomerPayment ?? default,
                             Debt = (bd.Invoice.TotalMoney - bd.Invoice.CustomerPayment) ?? default,
                             Note = bd.Invoice.Note
                         };


            var countlist = 1;
            List<MoneyReportViewModel> importlist = new List<MoneyReportViewModel>();

            foreach (var item in import)
            {
                MoneyReportViewModel list = new MoneyReportViewModel
                {
                    Count = countlist,
                    DateTime = item.DateTime,
                    CustomerName = item.CustomerName,
                    Vehicle = item.Vehicle,
                    Amount = item.Amount,
                    Money = item.Money,
                    CustomerPayment = item.CustomerPayment,
                    Debt = item.Debt,
                    Note = item.Note,
                };
                countlist += 1;
                importlist.Add(list);
            }
            var fileinfo = new FileInfo(string.Format(@"{0}\MoneyReport.xlsx", HostingEnvironment.MapPath("/Uploads")));
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    if (model.StationID.HasValue)
                    {
                        var station = db.Stations.Where(x => x.ID == model.StationID).FirstOrDefault();
                        productWorksheet.Cells[2, 1].Value = station.StationName.ToUpper();
                    }
                    else
                    {
                        productWorksheet.Cells[2, 1].Value = "Tất cả cửa hàng";
                    }
                    productWorksheet.Select();
                    productWorksheet.Cells[1, 1].Value = "BẢNG BÁO CÁO TIỀN MẶT ";
                    productWorksheet.Cells[3, 1].Value = " TỪ " + model.Time.ToUpper();
                    var count = import.Count();
                    var modelTable = productWorksheet.Cells[1, 1, count + 5, 9];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    for (int i = 0; i < count; i++)
                    {
                        var productInfo = importlist[i];
                        productWorksheet.Cells[i + 5, 1].Value = productInfo.Count;
                        productWorksheet.Cells[i + 5, 2].Value = productInfo.DateTime;
                        productWorksheet.Cells[i + 5, 3].Value = productInfo.CustomerName;
                        productWorksheet.Cells[i + 5, 4].Value = productInfo.Vehicle;
                        productWorksheet.Cells[i + 5, 5].Value = productInfo.Amount;
                        productWorksheet.Cells[i + 5, 6].Value = productInfo.Money;
                        productWorksheet.Cells[i + 5, 7].Value = productInfo.Debt;
                        productWorksheet.Cells[i + 5, 8].Value = productInfo.CustomerPayment;
                        productWorksheet.Cells[i + 5, 9].Value = productInfo.Note;

                        productWorksheet.Cells[i + 5, 5].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 5, 6].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 5, 7].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 5, 8].Style.Numberformat.Format = "#,##0.00";
                    }
                    productWorksheet.Cells[count + 5, 4].Value = "TỔNG";
                    productWorksheet.Cells[count + 5, 5].Formula = "=SUM(" + productWorksheet.Cells[4, 5, count + 4, 5] + ")";
                    productWorksheet.Cells[count + 5, 6].Formula = "=SUM(" + productWorksheet.Cells[4, 6, count + 4, 6] + ")";
                    productWorksheet.Cells[count + 5, 7].Formula = "=SUM(" + productWorksheet.Cells[4, 7, count + 4, 7] + ")";
                    productWorksheet.Cells[count + 5, 8].Formula = "=SUM(" + productWorksheet.Cells[4, 8, count + 4, 8] + ")";

                    productWorksheet.Cells[count + 5, 1, count + 5, 9].Style.Font.Bold = true;
                    productWorksheet.Cells[count + 5, 5].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[count + 5, 6].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[count + 5, 7].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[count + 5, 8].Style.Numberformat.Format = "#,##0.00";
                    return p.GetAsByteArray();
                }
            }

            return null;
        }
    }
}