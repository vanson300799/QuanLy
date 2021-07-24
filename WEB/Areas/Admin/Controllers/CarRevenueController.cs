using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Data.Entity;
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
    public class CarRevenueController : Controller
    {
        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        // GET: Admin/CarRevenue
        public ActionResult Index()
        {
            var model = new CarRevenueViewModel();
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID ?? default(int);
            }
            return View(model);
        }
        public ActionResult CarRevenueRead([DataSourceRequest] DataSourceRequest request, CarRevenueViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            DateTime timeStart = DateTime.ParseExact(model.StartTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            DateTime timeEnd = DateTime.ParseExact(model.EndTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            var import = from im in db.Invoices.Where(x => x.IsActive == true
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.IsActive))
                         && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd)
                         && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart)
                         && x.Vehicle != null && x.Vehicle != " ")

                         join st in db.Stations.Where(x => x.IsActive) on im.StationID equals st.ID into group2
                         from item2 in group2.DefaultIfEmpty()
                         select new CarRevenueViewModel()
                         {
                             InvoiceID = im.ID,
                             StationID = item2.ID,
                             StationName = item2.StationName,
                             Vehicle = im.Vehicle
                         };

            var result = import.GroupBy(m => new { m.Vehicle, m.StationID }).ToList();
            var count = 1;
            foreach (var group in result)
            {
                foreach (var item in group)
                {
                    var costmanage = db.CostManages.Where(x => x.IsActive
                    && x.StationID == item.StationID && x.Note == item.Vehicle
                    && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd)
                    && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart)).ToList();
                    decimal cost = costmanage.Sum(x => x.Money.HasValue ? x.Money.Value : 0);
                    item.Cost = cost;

                    decimal revenue = 0;
                    decimal amountReport = 0;
                    var revenueList = db.InvoiceDetailReports.Where(x => x.InvoiceDetail.Invoice.IsActive && x.IsActive && x.ParrentID == item.InvoiceID).ToList();

                    foreach (var revenueitem in revenueList)
                    {
                        revenue += (revenueitem.SaleAmount * revenueitem.FreightCharge);
                        amountReport += revenueitem.SaleAmount;
                    }
                    item.Amount = amountReport;
                    item.Revenue += revenue;
                }
            }

            if (!result.Any())
            {
                List<CarRevenueViewModel> resultnul = new List<CarRevenueViewModel>();
                return Json(resultnul.ToList(), JsonRequestBehavior.AllowGet);
            }
            var gridResult = result.Select(x => new CarRevenueViewModel()
            {
                Count = count++,
                StationID = x.Key.StationID,
                StationName = x.Select(y => y.StationName).FirstOrDefault(),
                Vehicle = x.Key.Vehicle,
                Amount = x.Sum(y => y.Amount),
                Revenue = x.Sum(y => y.Revenue)
            });
            return Json(gridResult, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(DetailImportViewModel model)
        {
            var result = DownloadCarRevenue(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Bao_cao_tong_hop_doanh_thu_xe.xlsx");
        }
        public byte[] DownloadCarRevenue(DetailImportViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            var fileinfo = new FileInfo(string.Format(@"{0}\CarRevenue.xlsx", HostingEnvironment.MapPath("/Uploads")));
            if (fileinfo.Exists)
            {
                DateTime timeStart = DateTime.ParseExact(model.StartTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
                DateTime timeEnd = DateTime.ParseExact(model.EndTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
                var import = from im in db.Invoices.Where(x => x.IsActive == true
                             && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.IsActive))
                             && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd)
                             && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart)
                             && x.Vehicle != null && x.Vehicle != " ")

                             join st in db.Stations.Where(x => x.IsActive) on im.StationID equals st.ID into group2
                             from item2 in group2.DefaultIfEmpty()
                             select new CarRevenueViewModel()
                             {
                                 InvoiceID = im.ID,
                                 StationID = item2.ID,
                                 StationName = item2.StationName,
                                 Vehicle = im.Vehicle
                             };

                var result = import.GroupBy(m => new { m.Vehicle, m.StationID }).ToList();
                var count = 1;
                foreach (var group in result)
                {
                    foreach (var item in group)
                    {
                        var costmanage = db.CostManages.Where(x => x.IsActive
                        && x.StationID == item.StationID && x.Note == item.Vehicle
                        && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd)
                        && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart)).ToList();
                        decimal cost = costmanage.Sum(x => x.Money.HasValue ? x.Money.Value : 0);
                        item.Cost = cost;

                        decimal revenue = 0;
                        decimal amountReport = 0;
                        var revenueList = db.InvoiceDetailReports.Where(x => x.InvoiceDetail.Invoice.IsActive && x.IsActive && x.ParrentID == item.InvoiceID).ToList();

                        foreach (var revenueitem in revenueList)
                        {
                            revenue += (revenueitem.SaleAmount * revenueitem.FreightCharge);
                            amountReport += revenueitem.SaleAmount;
                        }
                        item.Amount = amountReport;
                        item.Revenue += revenue;
                    }
                }
                var gridResult = result.Select(x => new CarRevenueViewModel()
                {
                    Count = count++,
                    StationID = x.Key.StationID,
                    StationName = x.Select(y => y.StationName).FirstOrDefault(),
                    Vehicle = x.Key.Vehicle,
                    Amount = x.Sum(y => y.Amount),
                    Revenue = x.Sum(y => y.Revenue)
                }).ToList();
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    productWorksheet.Select();
                    productWorksheet.Cells[1, 1].Value = "BÁO CÁO TỔNG HỢP DOANH THU XE";
                    productWorksheet.Cells[2, 1].Value = " TỪ " + model.Time.ToUpper();

                    productWorksheet.Cells[gridResult.Count() + 5, 1].Value = "Tổng";
                    var modelTable = productWorksheet.Cells[1, 1, gridResult.Count() + 5, 6];

                    productWorksheet.Cells[gridResult.Count() + 5, 4].Formula = "=SUM(" + productWorksheet.Cells[4, 4, gridResult.Count() + 3, 4] + ")";
                    productWorksheet.Cells[gridResult.Count() + 5, 5].Formula = "=SUM(" + productWorksheet.Cells[4, 5, gridResult.Count() + 3, 5] + ")";
                    productWorksheet.Cells[gridResult.Count() + 5, 6].Formula = "=SUM(" + productWorksheet.Cells[4, 6, gridResult.Count() + 3, 6] + ")";

                    productWorksheet.Cells[gridResult.Count() + 5, 1, result.Count() + 5, 3].Merge = true;
                    productWorksheet.Cells[gridResult.Count() + 5, 1, result.Count() + 5, 6].Style.Font.Bold = true;
                    productWorksheet.Cells[gridResult.Count() + 5, 4].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[gridResult.Count() + 5, 5].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[gridResult.Count() + 5, 6].Style.Numberformat.Format = "#,##0.00";
                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    if (gridResult.Count() != 0)
                    {
                        for (int i = 0; i < gridResult.Count(); i++)
                        {
                                var productInfo = gridResult[i];
                                var station = db.Stations.Where(x => x.ID == productInfo.StationID).FirstOrDefault();
                                productWorksheet.Cells[i + 4, 1].Value = productInfo.Count;
                                productWorksheet.Cells[i + 4, 2].Value = productInfo.Vehicle;
                                productWorksheet.Cells[i + 4, 3].Value = station.StationName;
                                productWorksheet.Cells[i + 4, 4].Value = productInfo.Amount;
                                productWorksheet.Cells[i + 4, 5].Value = productInfo.Revenue;
                                productWorksheet.Cells[i + 4, 6].Value = productInfo.Cost;

                                productWorksheet.Cells[i + 4, 4].Style.Numberformat.Format = "#,##0.00";
                                productWorksheet.Cells[i + 4, 5].Style.Numberformat.Format = "#,##0.00";
                                productWorksheet.Cells[i + 4, 6].Style.Numberformat.Format = "#,##0.00";
                        }
                        return p.GetAsByteArray();
                    }
                    else
                    {
                        return p.GetAsByteArray();
                    }
                }
            }
            return null;
        }
    }
}