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
    public class TrackOilSalesController : Controller
    {
        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        // GET: Admin/GeneralImport
        public ActionResult Index()
        {
            var model = new TrackOilSaleViewModel();
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID ?? default;
            }
            return View(model);
        }
        [AllowAnonymous]
        public JsonResult GetStation(string text)
        {
            var checkEmployee = WEB.WebHelpers.UserInfoHelper.GetUserData().StationID.HasValue;
            if (!checkEmployee)
            {
                var shop = from x in db.Stations.AsNoTracking()
                           where (x.IsActive == true)
                           select x;
                if (!string.IsNullOrEmpty(text))
                {
                    shop = shop.Where(p => p.StationName.Contains(text) || p.StationCode.Contains(text));
                }

                return Json(shop.ToList().Select(x => new
                {
                    ID = x.ID,
                    StationID = x.ID,
                    StationName = x.StationName,
                    StationDisplayName = string.Format("{0} : {1}", x.StationCode, x.StationName)
                }), JsonRequestBehavior.AllowGet);
            }
            else
            {
                var shop = from x in db.Stations.AsNoTracking()
                           where (x.IsActive == true && x.ID == WEB.WebHelpers.UserInfoHelper.GetUserData().StationID)
                           select x;
                if (!string.IsNullOrEmpty(text))
                {
                    shop = shop.Where(p => p.StationName.Contains(text) || p.StationCode.Contains(text));
                }

                return Json(shop.ToList().Select(x => new
                {
                    ID = x.ID,
                    StationID = x.ID,
                    StationName = x.StationName,
                    StationDisplayName = string.Format("{0} : {1}", x.StationCode, x.StationName)
                }), JsonRequestBehavior.AllowGet);
            }
        }

        public ActionResult OilSalesImportRead([DataSourceRequest] DataSourceRequest request, ImportViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            if (model.ProductID == null)
            {
                List<TrackOilSaleViewModel> importNull = new List<TrackOilSaleViewModel>();

                return Json(importNull.ToList(), JsonRequestBehavior.AllowGet);
            }

            DateTime startTime = DateTime.ParseExact(model.StartTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            DateTime endTime = DateTime.ParseExact(model.EndTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            var import = from invoid in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue? x.StationID == model.StationID : x.IsActive) )
                         && x.ProductID == model.ProductID
                    && (DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(startTime))
                    && (DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(endTime)))
                         join cus in db.Customers on invoid.Invoice.CustomerID equals cus.ID into group2
                         from cus in group2.DefaultIfEmpty()
                         join product in db.Products on invoid.ProductID equals product.ID into group3
                         from product in group3.DefaultIfEmpty()
                         select new
                         {
                             DateTime = (DateTime)invoid.Date,
                             Customer = cus.CustomerCode,
                             SaleNumber = (decimal)invoid.SaleAmount,
                             UnitPrice = invoid.SalePrice,
                             stringType = invoid.InvoiceType,
                             price = invoid.Money - invoid.CustomerPayment,
                             productName = product.ProductName,
                             Vehicle = invoid.Invoice.Vehicle,
                             invoid.CustomerPayment,
                             invoid.Money
                         };

            var importCheck = import.ToList();
            if (importCheck.Count == 0)
            {
                List<TrackOilSaleViewModel> importNull = new List<TrackOilSaleViewModel>();

                return Json(importNull.ToList(), JsonRequestBehavior.AllowGet);
            }
            else
            {
                List<TrackOilSaleViewModel> importList = new List<TrackOilSaleViewModel>();
                int i = 1;
                foreach (var item in import.OrderBy(x => x.DateTime))
                {
                    var trackOilSaleViewModel = new TrackOilSaleViewModel();
                    trackOilSaleViewModel.Count = i++;
                    trackOilSaleViewModel.DateTime = item.DateTime;
                    trackOilSaleViewModel.Customer = item.Customer;
                    trackOilSaleViewModel.SaleNumber = item.SaleNumber;
                    trackOilSaleViewModel.Vehicle = item.Vehicle;
                    trackOilSaleViewModel.UnitPrice = item.UnitPrice;
                    trackOilSaleViewModel.ProductDisplayName = item.productName;
                    trackOilSaleViewModel.PaidPrice = 0;
                    trackOilSaleViewModel.BookDebtPrice = 0;
                    trackOilSaleViewModel.CompanyDebtPrice = 0;

                    if (item.stringType == "Tiền mặt" || item.stringType == "Nợ tiền mặt")
                    {
                        trackOilSaleViewModel.PaidPrice = item.CustomerPayment;
                    }

                    if (item.stringType == "Hợp đồng")
                    {
                        trackOilSaleViewModel.CompanyDebtPrice = item.Money;
                    }
                    else
                    {
                        trackOilSaleViewModel.BookDebtPrice = item.price;
                    }


                    importList.Add(trackOilSaleViewModel);
                }
                return Json(importList.ToList(), JsonRequestBehavior.AllowGet);

            }


        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(TrackOilSaleViewModel model)
        {
            if (!ModelState.IsValid)
            {
                ModelState.AddModelError("", WebResources.ReportProduct);
                return View(model);
            }
            var result = DownloadGeneral(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Bang_theo_doi_ban_dau.xlsx");
        }
        public byte[] DownloadGeneral(TrackOilSaleViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            string datetime = model.Time.Replace("Đ", "d").Replace("ế", "e");
            string[] arrListStr = datetime.Split(new char[] { 'd', 'e', 'n' });
            DateTime startTime = DateTime.ParseExact(arrListStr[0].Trim(), "dd-MM-yyyy", CultureInfo.InvariantCulture);
            DateTime endTime = DateTime.ParseExact(arrListStr[3].Trim(), "dd-MM-yyyy", CultureInfo.InvariantCulture);

            var export = from invoid in db.InvoiceDetails.Where(x => x.IsActive == true && x.Invoice.IsActive
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.IsActive))
                         && x.ProductID == model.ProductID
              && (DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(startTime))
              && (DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(endTime)))
                         join cus in db.Customers on invoid.Invoice.CustomerID equals cus.ID into group2
                         from cus in group2.DefaultIfEmpty()
                         join product in db.Products on invoid.ProductID equals product.ID into group3
                         from product in group3.DefaultIfEmpty()
                         select new
                         {
                             DateTime = (DateTime)invoid.Date,
                             Customer = cus.CustomerCode,
                             SaleNumber = invoid.SaleAmount,
                             UnitPrice = invoid.SalePrice,
                             stringType = invoid.InvoiceType,
                             price = invoid.Money - invoid.CustomerPayment,
                             productName = product.ProductName,
                             Vehicle = invoid.Invoice.Vehicle,
                             invoid.Money,
                             invoid.CustomerPayment
                         };
            var test = export.ToList();
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            var fileinfo = new FileInfo(string.Format(@"{0}\Bảng_theo_dõi_bán_dầu.xlsx", HostingEnvironment.MapPath("/Uploads")));
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    productWorksheet.Select();
                    int i = 1;
                    productWorksheet.Cells[1, 2].Value = "BẢNG THEO DÕI BÁN " + export.FirstOrDefault().productName.ToUpper();
                    productWorksheet.Cells[2, 1].Value = "Từ " + model.Time.Replace("Đ", "đ");
                    var modelTable = productWorksheet.Cells[1, 1, export.Count() + 11, 11];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    foreach (var item in export.OrderBy(x => x.DateTime))
                    {
                        productWorksheet.Cells[i + 9, 1].Value = i;
                        productWorksheet.Cells[i + 9, 2].Value = item.DateTime.Day;
                        productWorksheet.Cells[i + 9, 3].Value = item.DateTime.ToString("dd/MM/yyyy");
                        productWorksheet.Cells[i + 9, 4].Value = item.Customer;

                        productWorksheet.Cells[i + 9, 5].Value = item.Vehicle;
                        productWorksheet.Cells[i + 9, 6].Value = item.SaleNumber;
                        productWorksheet.Cells[i + 9, 6].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 9, 7].Value = item.UnitPrice;
                        productWorksheet.Cells[i + 9, 7].Style.Numberformat.Format = "#,##0.00";

                        if (item.stringType == "Tiền mặt" || item.stringType == "Nợ tiền mặt")
                        {
                            productWorksheet.Cells[i + 9, 8].Value = item.CustomerPayment;
                            productWorksheet.Cells[i + 9, 8].Style.Numberformat.Format = "#,##0.00";
                        }
                        if (item.stringType == "Hợp đồng")
                        {
                            productWorksheet.Cells[i + 9, 9].Value = item.Money;
                            productWorksheet.Cells[i + 9, 9].Style.Numberformat.Format = "#,##0.00";
                        }
                        else
                        {
                            productWorksheet.Cells[i + 9, 10].Value = item.price;
                            productWorksheet.Cells[i + 9, 10].Style.Numberformat.Format = "#,##0.00";
                        }
                        productWorksheet.Cells[i + 9, 11].Value = item.productName;

                        i++;
                    }
                    productWorksheet.Cells[(i + 10), 6].Formula = "=SUM(" + productWorksheet.Cells[10, 6, (i + 8), 6] + ")";
                    productWorksheet.Cells["A" + (i + 10) + ":E" + (i + 10)].Merge = true;
                    productWorksheet.Cells[(i + 10), 1].Value = "Tổng";
                    productWorksheet.Cells[(i + 10), 8].Formula = "=SUM(" + productWorksheet.Cells[10, 8, (i + 8), 8] + ")";
                    productWorksheet.Cells[(i + 10), 9].Formula = "=SUM(" + productWorksheet.Cells[10, 9, (i + 8), 9] + ")";
                    productWorksheet.Cells[(i + 10), 10].Formula = "=SUM(" + productWorksheet.Cells[10, 10, (i + 8), 10] + ")";

                    productWorksheet.Cells[(i + 10), 6].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[(i + 10), 8].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[(i + 10), 9].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[(i + 10), 10].Style.Numberformat.Format = "#,##0.00";

                    return p.GetAsByteArray();
                }
            }

            return null;
        }

    }
}