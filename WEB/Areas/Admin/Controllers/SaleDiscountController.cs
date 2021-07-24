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
    public class SaleDiscountController : Controller
    {
        // GET: Admin/SaleDiscount
        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        public ActionResult Index()
        {
            var model = new SaleDiscountViewModel();
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID ?? default;
            }
            return View(model);
        }
        public ActionResult SaleDiscountRead([DataSourceRequest] DataSourceRequest request, ImportModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            DateTime timeStart = DateTime.ParseExact(model.StartTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            DateTime timeEnd = DateTime.ParseExact(model.EndTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            var countView = 0;
            var import = from ind in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive 
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                         && x.ProductID == model.ProductID
                         && x.InvoiceType != "Hợp đồng"
                         && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd)
                         && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart))

                         join cus in db.Customers.Where(x => x.IsActive) on ind.Invoice.CustomerID equals cus.ID into group1
                         from item1 in group1.DefaultIfEmpty()

                         join par in db.Invoices.Where(x => x.IsActive) on ind.ParrentID equals par.ID into group2
                         from item2 in group2.DefaultIfEmpty()

                         select new SaleDiscountViewModel()
                         {
                             DateTime = ind.Date,
                             CustomerCode = item1.CustomerCode,
                             SaleAmount = ind.SaleAmount,
                             CostPrice = ind.CostPrice,
                             SalePrice = ind.SalePrice,
                             ListedPrice = ind.ListPrice,
                             Note = item2.Note,
                             Discount = ind.ListPrice - ind.SalePrice,
                             Money = ind.SaleAmount * (ind.ListPrice - ind.SalePrice),
                         };
            var importCheck = import.ToList();
            foreach (var item in importCheck)
            {
                countView += 1;
                item.Count = countView;
            }
            if (importCheck.Count == 0)
            {
                List<SaleDiscountViewModel> importNull = new List<SaleDiscountViewModel>();

                return Json(importNull.ToList(), JsonRequestBehavior.AllowGet);
            }
            return Json(importCheck.ToList(), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(ImportModel model)
        {
            var result = DownloadsaleDiscount(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Chiet_khau_ban_hang.xlsx");

        }
        public byte[] DownloadsaleDiscount(ImportModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            var fileinfo = new FileInfo(string.Format(@"{0}\SaleDiscount.xlsx", HostingEnvironment.MapPath("/Uploads")));
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
                var import = from ind in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                         && x.ProductID == model.ProductID
                         && x.InvoiceType != "Hợp đồng"
                         && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd)
                         && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart))

                             join cus in db.Customers.Where(x => x.IsActive) on ind.Invoice.CustomerID equals cus.ID into group1
                             from item1 in group1.DefaultIfEmpty()

                             join par in db.Invoices.Where(x => x.IsActive) on ind.ParrentID equals par.ID into group2
                             from item2 in group2.DefaultIfEmpty()

                             select new SaleDiscountViewModel()
                             {
                                 DateTime = ind.Date,
                                 CustomerCode = item1.CustomerCode,
                                 SaleAmount = ind.SaleAmount,
                                 CostPrice = ind.CostPrice,
                                 SalePrice = ind.SalePrice,
                                 ListedPrice = ind.ListPrice,
                                 Note = item2.Note,
                                 Discount = ind.ListPrice - ind.SalePrice,
                                 Money = ind.SaleAmount * (ind.ListPrice - ind.SalePrice),
                             };
                var importCheck = import.ToList();
                foreach (var item in importCheck)
                {
                    countView += 1;
                    item.Count = countView;
                }
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    var product = db.Products.FirstOrDefault(x => x.ID == model.ProductID);
                    var station = db.Stations.FirstOrDefault(x => x.ID == model.StationID);
                    productWorksheet.Select();
                    productWorksheet.Cells[2, 1].Value = "Từ " + dayStartExcel + "/" + monthStartExcel + "/" + yearStartExcel + " Đến " + dayEndExcel + "/" + monthEndExcel + "/" + yearEndExcel;
                    productWorksheet.Cells[3, 1].Value = "Cửa Hàng: " + station.StationName;
                    productWorksheet.Cells[4, 1].Value = "Hàng Hóa: " + product.ProductName;
                    productWorksheet.Cells[importCheck.Count + 7, 3].Value = "Tổng";
                    productWorksheet.Cells[importCheck.Count + 7, 4].Formula = "=SUM(" + productWorksheet.Cells[6, 4, importCheck.Count + 5, 4] + ")";
                    productWorksheet.Cells[importCheck.Count + 7, 8].Formula = "=SUM(" + productWorksheet.Cells[6, 8, importCheck.Count + 5, 8] + ")";

                    productWorksheet.Cells[importCheck.Count + 7, 1, importCheck.Count + 7, 9].Style.Font.Bold = true;
                    productWorksheet.Cells[importCheck.Count + 7, 8].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[importCheck.Count + 7, 4].Style.Numberformat.Format = "#,##0.00";

                    var modelTable = productWorksheet.Cells[1, 1, importCheck.Count() + 7, 9];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    if (importCheck.Count != 0)
                    {
                        for (int i = 0; i < importCheck.Count; i++)
                        {
                            var productInfo = importCheck[i];
                            productWorksheet.Cells[i + 6, 1].Value = productInfo.Count;
                            productWorksheet.Cells[i + 6, 2].Value = productInfo.DateTime;
                            productWorksheet.Cells[i + 6, 3].Value = productInfo.CustomerCode;
                            productWorksheet.Cells[i + 6, 4].Value = productInfo.SaleAmount;
                            productWorksheet.Cells[i + 6, 5].Value = productInfo.SalePrice;
                            productWorksheet.Cells[i + 6, 6].Value = productInfo.ListedPrice;
                            productWorksheet.Cells[i + 6, 7].Value = productInfo.Discount;
                            productWorksheet.Cells[i + 6, 8].Value = productInfo.Money;
                            productWorksheet.Cells[i + 6, 9].Value = productInfo.Note;

                            productWorksheet.Cells[i + 6, 4].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 6, 5].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 6, 6].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 6, 7].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 6, 8].Style.Numberformat.Format = "#,##0.00";

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