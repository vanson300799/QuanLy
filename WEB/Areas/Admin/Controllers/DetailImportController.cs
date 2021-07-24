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
    public class DetailImportController : Controller
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
            var model = new DetailImportViewModel();
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID ?? default;
            }
            return View(model);
        }
        public ActionResult DetailImportRead([DataSourceRequest] DataSourceRequest request, DetailImportViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            DateTime timeStart = DateTime.ParseExact(model.StartTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            DateTime timeEnd = DateTime.ParseExact(model.EndTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            var countView = 0;
            var import = from im in db.ImportOrderDetails.Where(x => x.IsActive && x.ImportOrder.IsActive
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.IsActive))
                         && (model.ProductID.HasValue ? x.ProductID == model.ProductID : x.IsActive) &&
                         DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd) &&
                         DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart))

                         join pr in db.Products.Where(x => x.IsActive) on im.ProductID equals pr.ID into group1
                         from item1 in group1.DefaultIfEmpty()

                         join st in db.Stations.Where(x => x.IsActive) on im.StationID equals st.ID into group2
                         from item2 in group2.DefaultIfEmpty()

                         join parent in db.ImportOrders.Where(x => x.IsActive) on im.ParrentID equals parent.ID into group3
                         from item3 in group3.DefaultIfEmpty()
                         select new DetailImportReportModel()
                         {
                             ProductName = item1.ProductName,
                             ProductID = im.ProductID,
                             DateTime = im.Date,
                             StationID = item2.ID,
                             StationName = item2.StationName,
                             InputNumber = im.InputNumber,
                             InputPrice = im.InputPrice,
                             InvoiceCode = item3.InvoiceCode,
                             CostPrice = (decimal) im.InputNumber * (decimal)im.InputPrice * (decimal)1.1
                         };
            if (import == null)
            {
                List<DetailImportReportModel> importNull = new List<DetailImportReportModel>();

                return Json(importNull.ToList(), JsonRequestBehavior.AllowGet);
            }

            var importCheck = import.ToList();
            foreach (var item in importCheck)
            {   
                var Listedprice = db.ListedPrices.OrderByDescending(x => x.TimeApply).FirstOrDefault(x => x.IsActive && x.ProductID == item.ProductID && DbFunctions.TruncateTime(x.TimeApply) <= DbFunctions.TruncateTime(item.DateTime));
                item.ListedPrice = Listedprice != null ? Listedprice.PriceListed : 0;
                countView += 1;
                item.Count = countView;
            }
            return Json(importCheck.ToList(), JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(DetailImportViewModel model)
        {
            var result = DownloadDetailImport(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Nhap_hang_chi_tiet.xlsx");
        }
        public byte[] DownloadDetailImport(DetailImportViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            var fileinfo = new FileInfo(string.Format(@"{0}\DetailImport.xlsx", HostingEnvironment.MapPath("/Uploads")));
            if (fileinfo.Exists)
            {
                var timeArr = model.Time.Split(' ');
                var start = timeArr[0];
                var end = timeArr[2];
                DateTime timeStart = DateTime.ParseExact(start, "dd-MM-yyyy", CultureInfo.InvariantCulture);
                DateTime timeEnd = DateTime.ParseExact(end, "dd-MM-yyyy", CultureInfo.InvariantCulture);
                var timeStartExcel = timeStart;
                var timeEndExcel = timeEnd;
                var dayStartExcel = timeStart.Day;
                var monthStartExcel = timeStart.Month;
                var yearStartExcel = timeStart.Year;
                var dayEndExcel = timeEnd.Day;
                var monthEndExcel = timeEnd.Month;
                var yearEndExcel = timeEnd.Year;
                var countView = 0;

                var import = from im in db.ImportOrderDetails.Where(x => x.IsActive && x.ImportOrder.IsActive
                           && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.IsActive))
                            && (model.ProductID.HasValue ? x.ProductID == model.ProductID : x.IsActive) &&
                            DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd) &&
                            DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart))

                             join pr in db.Products.Where(x => x.IsActive) on im.ProductID equals pr.ID into group1
                             from item1 in group1.DefaultIfEmpty()

                             join st in db.Stations.Where(x => x.IsActive) on im.StationID equals st.ID into group2
                             from item2 in group2.DefaultIfEmpty()

                             join parent in db.ImportOrders.Where(x => x.IsActive) on im.ParrentID equals parent.ID into group3
                             from item3 in group3.DefaultIfEmpty()

                             select new DetailImportReportModel()
                             {
                                 ProductName = item1.ProductName,
                                 ProductID = im.ProductID,
                                 DateTime = im.Date,
                                 StationID = item2.ID,
                                 StationName = item2.StationName,
                                 InputNumber = im.InputNumber,
                                 InputPrice = im.InputPrice,
                                 InvoiceCode = item3.InvoiceCode,
                                 CostPrice = (decimal)im.InputNumber * (decimal)im.InputPrice * (decimal)1.1
                             };
                var importCheck = import.ToList();
                foreach (var item in importCheck)
                {
                    var Listedprice = db.ListedPrices.OrderByDescending(x => x.TimeApply).FirstOrDefault(x => x.IsActive 
                    && x.ProductID == item.ProductID 
                    && DbFunctions.TruncateTime(x.TimeApply) <= DbFunctions.TruncateTime(item.DateTime));
                    item.ListedPrice = Listedprice != null ? Listedprice.PriceListed : 0;
                    countView += 1;
                    item.Count = countView;
                }
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    productWorksheet.Select();
                    productWorksheet.Cells[2, 1].Value = "Từ " + dayStartExcel + "/" + monthStartExcel + "/" + yearStartExcel + " Đến " + dayEndExcel + "/" + monthEndExcel + "/" + yearEndExcel;
                    if (model.StationID.HasValue)
                    {
                        var station = db.Stations.FirstOrDefault(x => x.ID == model.StationID);
                        productWorksheet.Cells[3, 1].Value = "Cửa Hàng:" + station.StationName;
                    }
                    else
                    {
                        productWorksheet.Cells[3, 1].Value = "Cửa Hàng: Toàn bộ";
                    }

                    if (model.ProductID.HasValue)
                    {
                        var product = db.Products.FirstOrDefault(x => x.ID == model.ProductID);
                        productWorksheet.Cells[4, 1].Value = "Hàng Hóa: " + product.ProductName;
                    }
                    else
                    {
                        productWorksheet.Cells[4, 1].Value = "Hàng Hóa: Toàn bộ";
                    }
                    productWorksheet.Cells[importCheck.Count + 8, 6].Value = "Tổng";
                    productWorksheet.Cells[importCheck.Count + 8, 5].Formula = "=SUM(" + productWorksheet.Cells[7, 5, importCheck.Count + 6, 5] + ")";
                    productWorksheet.Cells[importCheck.Count + 8, 7].Formula = "=SUM(" + productWorksheet.Cells[7, 7, importCheck.Count + 6, 7] + ")";
                    productWorksheet.Cells[importCheck.Count + 8, 5].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[importCheck.Count + 8, 7].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[importCheck.Count + 8, 5].Style.Font.Bold = true;
                    productWorksheet.Cells[importCheck.Count + 8, 6].Style.Font.Bold = true;
                    productWorksheet.Cells[importCheck.Count + 8, 7].Style.Font.Bold = true;

                    var modelTable = productWorksheet.Cells[1, 1, importCheck.Count + 8, 8];
                    modelTable.Style.Font.Name = "Calibri";
                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    if (importCheck.Count != 0)
                    {
                        for (int i = 0; i < importCheck.Count; i++)
                        {
                            var productInfo = importCheck[i];
                            productWorksheet.Cells[i + 7, 1].Value = productInfo.Count;
                            productWorksheet.Cells[i + 7, 2].Value = productInfo.DateTime;
                            productWorksheet.Cells[i + 7, 3].Value = productInfo.InvoiceCode;
                            productWorksheet.Cells[i + 7, 4].Value = productInfo.InputPrice;
                            productWorksheet.Cells[i + 7, 5].Value = productInfo.InputNumber;
                            productWorksheet.Cells[i + 7, 6].Value = productInfo.StationName;
                            productWorksheet.Cells[i + 7, 7].Value = productInfo.CostPrice;
                            productWorksheet.Cells[i + 7, 8].Value = productInfo.ListedPrice;

                            productWorksheet.Cells[i + 7, 4].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 7, 4].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 7, 7].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 7, 8].Style.Numberformat.Format = "#,##0.00";
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