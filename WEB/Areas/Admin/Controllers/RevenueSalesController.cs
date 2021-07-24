using Common;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Data.Entity;
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
    public class RevenueSalesController : Controller
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
            var model = new RevenueSalesViewModel();
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID ?? default;
            }
            return View(model);
        }

        private List<RevenueSalesViewModel> GetResult(RevenueSalesViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);

            var revenueSale = from bd in db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive
                              && x.InvoiceDetail.Invoice.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                         && (model.ProductID.HasValue ? x.ProductID == model.ProductID : x.IsActive)
                         && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end) && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start))
                              join iv in db.Invoices on bd.ParrentID equals iv.ID
                              join pd in db.Products on bd.ProductID equals pd.ID into group3

                              from item3 in group3.DefaultIfEmpty()
                              join ct in db.Customers on iv.CustomerID equals ct.ID into group4

                              from item4 in group4.DefaultIfEmpty()
                              select new RevenueSalesViewModel
                              {
                                  ProductID = bd.ProductID,
                                  ProductCode = item3.ProductCode,
                                  Vehicle = iv.Vehicle,
                                  ProductName = item3.ProductName,
                                  SaleAmount = bd.SaleAmount,
                                  CostPrice = bd.CostPrice,
                                  SalePrice = bd.ListPrice / (decimal)1.1,
                                  CustomerCode = item4.CustomerCode,
                                  CostPriceCal = bd.CostPrice * bd.SaleAmount,
                                  Revenue = bd.SaleAmount * (bd.ListPrice / (decimal)1.1),
                                  RevenueSale = bd.SaleAmount * (bd.ListPrice / (decimal)1.1) - (bd.CostPrice * bd.SaleAmount),
                                  InvoiceCode = iv.InvoiceCode,
                                  RevenueInvoice = bd.InvoiceRevenue,
                                  Note = iv.Note,
                                  DateTime = (DateTime)bd.Date
                              };
            List<RevenueSalesViewModel> listRevenueSale = new List<RevenueSalesViewModel>();
            var count = 1;
            foreach (var item in revenueSale)
            {
                RevenueSalesViewModel list = new RevenueSalesViewModel
                {
                    Count = count,
                    CostPrice = item.CostPrice,
                    InvoiceCode = item.InvoiceCode,
                    CostPriceCal = item.CostPriceCal,
                    CustomerCode = item.CustomerCode,
                    Vehicle = item.Vehicle,
                    DateTime = item.DateTime,
                    Note = item.Note,
                    RevenueSale = item.RevenueSale,
                    SaleAmount = item.SaleAmount,
                    Revenue = item.Revenue,
                    RevenueInvoice = item.RevenueInvoice.HasValue ? item.RevenueInvoice : 0,
                    SalePrice = item.SalePrice,
                };
                count += 1;
                listRevenueSale.Add(list);
            }

            return listRevenueSale;
        }

        public ActionResult RevenueSales_Read([DataSourceRequest] DataSourceRequest request, RevenueSalesViewModel model)
        {
            return Json(GetResult(model), JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(RevenueSalesViewModel model)
        {

            var result = DownloadRevenueSales(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Doanh_thu_ban_hang_theo_cua_hang.xlsx");
        }
        public byte[] DownloadRevenueSales(RevenueSalesViewModel model)
        {
            var exportResult = GetResult(model);
            var fileinfo = new FileInfo(string.Format(@"{0}\RevenueSales.xlsx", HostingEnvironment.MapPath("/Uploads")));
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    var station = db.Stations.Where(x => x.ID == model.StationID).FirstOrDefault();
                    productWorksheet.Select();
                    productWorksheet.Cells[1, 1].Value = "DOANH THU BÁN HÀNG CỬA HÀNG " + station.StationName.ToUpper() + " TỪ " + model.Time.ToUpper();
                    var countlist = exportResult.Count();
                    for (int i = 0; i < countlist; i++)
                    {
                        var productInfo = exportResult[i];
                        productWorksheet.Cells[i + 3, 1].Value = productInfo.Count;
                        productWorksheet.Cells[i + 3, 2].Value = productInfo.DateTime;
                        productWorksheet.Cells[i + 3, 3].Value = productInfo.CustomerCode;
                        productWorksheet.Cells[i + 3, 4].Value = productInfo.SaleAmount;
                        productWorksheet.Cells[i + 3, 5].Value = productInfo.SalePrice;
                        productWorksheet.Cells[i + 3, 6].Value = productInfo.CostPrice;
                        productWorksheet.Cells[i + 3, 7].Value = productInfo.CostPriceCal;
                        productWorksheet.Cells[i + 3, 8].Value = productInfo.Revenue;
                        productWorksheet.Cells[i + 3, 9].Value = productInfo.RevenueSale;
                        productWorksheet.Cells[i + 3, 10].Value = productInfo.RevenueInvoice;
                        productWorksheet.Cells[i + 3, 11].Value = productInfo.Note;
                        productWorksheet.Cells[i + 3, 12].Value = productInfo.Vehicle;

                        productWorksheet.Cells[i + 3, 4].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 3, 5].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 3, 6].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 3, 7].Style.Numberformat.Format = "#,##0";
                        productWorksheet.Cells[i + 3, 8].Style.Numberformat.Format = "#,##0";
                        productWorksheet.Cells[i + 3, 9].Style.Numberformat.Format = "#,##0";
                        productWorksheet.Cells[i + 3, 10].Style.Numberformat.Format = "#,##0";
                    }
                    productWorksheet.Cells[countlist + 4, 1].Value = "Tổng";
                    productWorksheet.Cells[countlist + 4, 4].Formula = "=SUM(" + productWorksheet.Cells[3, 4, countlist + 2, 4] + ")";
                    productWorksheet.Cells[countlist + 4, 7].Formula = "=SUM(" + productWorksheet.Cells[3, 7, countlist + 2, 7] + ")";
                    productWorksheet.Cells[countlist + 4, 8].Formula = "=SUM(" + productWorksheet.Cells[3, 8, countlist + 2, 8] + ")";
                    productWorksheet.Cells[countlist + 4, 9].Formula = "=SUM(" + productWorksheet.Cells[3, 9, countlist + 2, 9] + ")";
                    productWorksheet.Cells[countlist + 4, 10].Formula = "=SUM(" + productWorksheet.Cells[3, 10, countlist + 2, 10] + ")";


                    productWorksheet.Cells[countlist + 4, 1, countlist + 4, 10].Style.Font.Bold = true;
                    productWorksheet.Cells[countlist + 4, 4].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[countlist + 4, 7].Style.Numberformat.Format = "#,##0";
                    productWorksheet.Cells[countlist + 4, 8].Style.Numberformat.Format = "#,##0";
                    productWorksheet.Cells[countlist + 4, 9].Style.Numberformat.Format = "#,##0";
                    productWorksheet.Cells[countlist + 4, 10].Style.Numberformat.Format = "#,##0";

                    //border
                    var modelTable = productWorksheet.Cells[1, 1, countlist + 4, 12];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    return p.GetAsByteArray();
                }
            }

            return null;
        }
    }
}