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
using WebMatrix.WebData;
using WebModels;

namespace WEB.Areas.Admin.Controllers
{
    public class SaleNotesController : Controller
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
            var model = new SaleNotesViewModel();
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
                var stationID = WebHelpers.UserInfoHelper.GetUserData().StationID;
                var shop = from x in db.Stations.AsNoTracking()
                           where x.IsActive == true && x.ID == stationID
                           select x;

                if (!string.IsNullOrEmpty(text))
                {
                    shop = shop.Where(p => p.StationName.Contains(text) || p.StationCode.Contains(text));
                }

                if (shop.ToList().Count == 0)
                {
                    List<Station> findNull = new List<Station>();

                    return Json(findNull.ToList(), JsonRequestBehavior.AllowGet);
                }
                else
                {
                    return Json(shop.ToList().Select(x => new
                    {
                        ID = x.ID,
                        StationID = x.ID,
                        StationName = x.StationName,
                        StationDisplayName = string.Format("{0} : {1}", x.StationCode, x.StationName)
                    }), JsonRequestBehavior.AllowGet);
                }
            }
        }

        public ActionResult SaleNotesRead([DataSourceRequest] DataSourceRequest request, ImportViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            if (model.StationID == 0 && model.ProductID == null)
            {
                List<SaleNotesViewModel> importNull = new List<SaleNotesViewModel>();
                return Json(importNull.ToList(), JsonRequestBehavior.AllowGet);
            }
            DateTime startTime = DateTime.ParseExact(model.StartTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            DateTime endTime = DateTime.ParseExact(model.EndTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);

            var import = from invoid in db.InvoiceDetailReports.Where(x => x.IsActive == true
                         && x.InvoiceDetail.IsActive
                         && x.InvoiceDetail.Invoice.IsActive
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                         && x.ProductID == model.ProductID
                         && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(startTime)
                         && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(endTime))

                         join cus in db.Customers on invoid.InvoiceDetail.Invoice.CustomerID equals cus.ID into group2
                         from cus in group2.DefaultIfEmpty()
                         join product in db.Products on invoid.ProductID equals product.ID into group3
                         from product in group3.DefaultIfEmpty()
                         select new InvoiceDetailReportResult
                         {
                             ID = invoid.ID,
                             DateTime = (DateTime)invoid.Date,
                             Customer = cus.CustomerCode,
                             SaleNumber = invoid.SaleAmount,
                             UnitPrice = invoid.SalePrice,
                             StringType = invoid.InvoiceType,
                             Vehicle = invoid.InvoiceDetail.Invoice.Vehicle,
                             Price = (invoid.Money - invoid.CustomerPayment),
                             ProductName = product.ProductName,
                             ListPrice = invoid.ListPrice,
                             CostPrice = invoid.CostPrice,
                             SupplierDiscount = invoid.SupplierDiscount,
                             FreightCharge = invoid.FreightCharge * invoid.SaleAmount,
                             CustomerPayment = invoid.CustomerPayment,
                             Money = invoid.Money,
                             InvoiceDetailId = invoid.InvoiceDetailId
                         };
            var importCheck = import.ToList();
            var test = import.Where(x => x.ID == 16778).ToList();
            if (importCheck.Count == 0)
            {
                List<SaleNotesViewModel> importNull = new List<SaleNotesViewModel>();
                return Json(importNull.ToList(), JsonRequestBehavior.AllowGet);
            }
            else
            {
                List<SaleNotesViewModel> importList = new List<SaleNotesViewModel>();
                var orderedList = import.OrderBy(x => x.DateTime).ThenBy(y => y.ID).ToList();
                foreach (var item in orderedList)
                {
                    var saleNoteViewModel = new SaleNotesViewModel
                    {
                        DateTime = item.DateTime,
                        Customer = item.Customer,
                        SaleNumber = item.SaleNumber,
                        UnitPrice = item.UnitPrice,
                        ListedPrice = item.ListPrice,
                        SupplierDiscount = item.SupplierDiscount
                    };

                    saleNoteViewModel.ListedPriceBeforeTax = (saleNoteViewModel.ListedPrice / (decimal)1.1);
                    saleNoteViewModel.CostPriceBeforeTax = item.CostPrice;
                    saleNoteViewModel.Vehicle = item.Vehicle;
                    saleNoteViewModel.Freight = item.FreightCharge;
                    saleNoteViewModel.Freight = saleNoteViewModel.Freight.HasValue ? saleNoteViewModel.Freight : 0;
                    saleNoteViewModel.Discount = saleNoteViewModel.ListedPriceBeforeTax * saleNoteViewModel.SaleNumber - saleNoteViewModel.CostPriceBeforeTax * saleNoteViewModel.SaleNumber;
                    saleNoteViewModel.ProductDisplayName = item.ProductName;
                    saleNoteViewModel.PaidPrice = 0;
                    saleNoteViewModel.BookDebtPrice = 0;
                    saleNoteViewModel.CompanyDebtPrice = 0;

                    if (item.StringType == "Tiền mặt")
                    {
                        saleNoteViewModel.PaidPrice = item.CustomerPayment;
                    }

                    if (item.StringType == "Nợ tiền mặt")
                    {
                        if (item.CustomerPayment < item.Money)
                        {
                            saleNoteViewModel.PaidPrice = item.CustomerPayment;
                            saleNoteViewModel.BookDebtPrice = item.Money - item.CustomerPayment;
                        }
                        else if (item.CustomerPayment == item.Money)
                        {
                            saleNoteViewModel.PaidPrice = item.CustomerPayment;
                        }
                        else
                        {
                            saleNoteViewModel.PaidPrice = item.Money;
                            foreach (var sameInvoiceDetailItem in orderedList.Where(x => x.ID != item.ID && x.InvoiceDetailId == item.InvoiceDetailId))
                            {
                                sameInvoiceDetailItem.CustomerPayment = item.CustomerPayment - item.Money;
                            }
                        }
                    }

                    if (item.StringType == "Hợp đồng")
                    {
                        saleNoteViewModel.CompanyDebtPrice = item.Money;
                    }


                    importList.Add(saleNoteViewModel);
                }

                return Json(importList.ToList(), JsonRequestBehavior.AllowGet);
            }
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(SaleNotesViewModel model)
        {
            var result = DownloadGeneral(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Phan_tich_gia.xlsx");
        }
        public byte[] DownloadGeneral(SaleNotesViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";
            var startTime = DateTime.ParseExact(model.StartTime, format, provider);
            var endTime = DateTime.ParseExact(model.EndTime, format, provider);

            var import = from invoid in db.InvoiceDetailReports.Where(x => x.IsActive == true
                         && x.InvoiceDetail.IsActive
                         && x.InvoiceDetail.Invoice.IsActive
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                         && x.ProductID == model.ProductID
                         && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(startTime)
                         && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(endTime))

                         join cus in db.Customers on invoid.InvoiceDetail.Invoice.CustomerID equals cus.ID into group2
                         from cus in group2.DefaultIfEmpty()
                         join product in db.Products on invoid.ProductID equals product.ID into group3
                         from product in group3.DefaultIfEmpty()
                         select new InvoiceDetailReportResult
                         {
                             ID = invoid.ID,
                             DateTime = (DateTime)invoid.Date,
                             Customer = cus.CustomerCode,
                             SaleNumber = invoid.SaleAmount,
                             UnitPrice = invoid.SalePrice,
                             StringType = invoid.InvoiceType,
                             Vehicle = invoid.InvoiceDetail.Invoice.Vehicle,
                             Price = (invoid.Money - invoid.CustomerPayment),
                             ProductName = product.ProductName,
                             ListPrice = invoid.ListPrice,
                             CostPrice = invoid.CostPrice,
                             SupplierDiscount = invoid.SupplierDiscount,
                             FreightCharge = invoid.FreightCharge * invoid.SaleAmount,
                             CustomerPayment = invoid.CustomerPayment,
                             Money = invoid.Money,
                             InvoiceDetailId = invoid.InvoiceDetailId
                         };
            var importCheck = import.ToList();
            
            List<SaleNotesViewModel> importList = new List<SaleNotesViewModel>();
            var orderedList = import.OrderBy(x => x.DateTime).ThenBy(y => y.ID).ToList();
            foreach (var item in orderedList)
            {
                var saleNoteViewModel = new SaleNotesViewModel
                {
                    DateTime = item.DateTime,
                    Customer = item.Customer,
                    SaleNumber = item.SaleNumber,
                    UnitPrice = item.UnitPrice,
                    ListedPrice = item.ListPrice,
                    SupplierDiscount = item.SupplierDiscount
                };

                saleNoteViewModel.ListedPriceBeforeTax = (saleNoteViewModel.ListedPrice / (decimal)1.1);
                saleNoteViewModel.CostPriceBeforeTax = item.CostPrice;
                saleNoteViewModel.Vehicle = item.Vehicle;
                saleNoteViewModel.Freight = item.FreightCharge;
                saleNoteViewModel.Freight = saleNoteViewModel.Freight.HasValue ? saleNoteViewModel.Freight : 0;
                saleNoteViewModel.Discount = saleNoteViewModel.ListedPriceBeforeTax * saleNoteViewModel.SaleNumber - saleNoteViewModel.CostPriceBeforeTax * saleNoteViewModel.SaleNumber;
                saleNoteViewModel.ProductDisplayName = item.ProductName;
                saleNoteViewModel.PaidPrice = 0;
                saleNoteViewModel.BookDebtPrice = 0;
                saleNoteViewModel.CompanyDebtPrice = 0;

                if (item.StringType == "Tiền mặt")
                {
                    saleNoteViewModel.PaidPrice = item.CustomerPayment;
                }

                if (item.StringType == "Nợ tiền mặt")
                {
                    if (item.CustomerPayment < item.Money)
                    {
                        saleNoteViewModel.PaidPrice = item.CustomerPayment;
                        saleNoteViewModel.BookDebtPrice = item.Money - item.CustomerPayment;
                    }
                    else if (item.CustomerPayment == item.Money)
                    {
                        saleNoteViewModel.PaidPrice = item.CustomerPayment;
                    }
                    else
                    {
                        saleNoteViewModel.PaidPrice = item.Money;
                        foreach (var sameInvoiceDetailItem in orderedList.Where(x => x.ID != item.ID && x.InvoiceDetailId == item.InvoiceDetailId))
                        {
                            sameInvoiceDetailItem.CustomerPayment = item.CustomerPayment - item.Money;
                        }
                    }
                }

                if (item.StringType == "Hợp đồng")
                {
                    saleNoteViewModel.CompanyDebtPrice = item.Money;
                }

                importList.Add(saleNoteViewModel);
            }

            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            var fileinfo = new FileInfo(string.Format(@"{0}\SaleNote.xlsx", HostingEnvironment.MapPath("/Uploads")));
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    productWorksheet.Select();
                    int i = 6;
                    productWorksheet.Cells[2, 1].Value = "Từ " + model.Time.Replace("Đ", "đ");
                    var station = db.Stations.Where(x => x.ID == model.StationID).FirstOrDefault();
                    productWorksheet.Cells[3, 1].Value = station.StationName;
                    foreach (var item in importList.OrderBy(x => x.DateTime))
                    {
                        productWorksheet.Cells[i, 1].Value = item.DateTime.ToString("dd/MM/yyyy");
                        productWorksheet.Cells[i, 2].Value = item.Customer;
                        productWorksheet.Cells[i, 3].Value = item.Vehicle;
                        productWorksheet.Cells[i, 4].Value = item.SaleNumber;
                        productWorksheet.Cells[i, 5].Value = item.UnitPrice;
                        productWorksheet.Cells[i, 5].Style.Numberformat.Format = "#,##0.00";
                        var listPricebefore = (double)item.ListedPrice / 1.1;
                        productWorksheet.Cells[i, 6].Value = item.ListedPrice;
                        productWorksheet.Cells[i, 6].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i, 7].Value = listPricebefore;
                        productWorksheet.Cells[i, 7].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i, 8].Value = item.CostPriceBeforeTax;
                        productWorksheet.Cells[i, 8].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i, 9].Value = item.SupplierDiscount;
                        productWorksheet.Cells[i, 9].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i, 10].Value = (double?)item.Freight;
                        productWorksheet.Cells[i, 10].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i, 11].Value = item.PaidPrice;
                        productWorksheet.Cells[i, 11].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i, 12].Value = item.CompanyDebtPrice;
                        productWorksheet.Cells[i, 12].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i, 13].Value = item.BookDebtPrice;
                        productWorksheet.Cells[i, 13].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i, 15].Value = item.Discount;
                        productWorksheet.Cells[i, 15].Style.Numberformat.Format = "#,##0.00";
                        i++;
                    }
                    productWorksheet.Cells[i + 1, 2].Value = "Tổng";
                    productWorksheet.Cells[i + 1, 4].Formula = "=SUM(" + productWorksheet.Cells[6, 4, i - 1, 4] + ")";
                    productWorksheet.Cells[i + 1, 10].Formula = "=SUM(" + productWorksheet.Cells[6, 10, i - 1, 10] + ")";
                    productWorksheet.Cells[i + 1, 15].Formula = "=SUM(" + productWorksheet.Cells[6, 15, i - 1, 15] + ")"; ;
                    productWorksheet.Cells[i + 1, 11].Formula = "=SUM(" + productWorksheet.Cells[6, 11, i - 1, 11] + ")"; ;
                    productWorksheet.Cells[i + 1, 12].Formula = "=SUM(" + productWorksheet.Cells[6, 12, i - 1, 12] + ")"; ;
                    productWorksheet.Cells[i + 1, 13].Formula = "=SUM(" + productWorksheet.Cells[6, 13, i - 1, 13] + ")"; ;

                    productWorksheet.Cells[i + 1, 4].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[i + 1, 10].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[i + 1, 15].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[i + 1, 11].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[i + 1, 12].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[i + 1, 13].Style.Numberformat.Format = "#,##0.00";

                    productWorksheet.Cells[i + 1, 1, i + 1, 14].Style.Font.Bold = true;

                    var modelTable = productWorksheet.Cells[1, 1, i + 1, 15];

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

    public class InvoiceDetailReportResult
    {
        public int ID { get; set; }
        public DateTime DateTime { get; set; }
        public string Customer { get; set; }
        public decimal SaleNumber { get; set; }
        public decimal UnitPrice { get; set; }
        public string StringType { get; set; }
        public decimal Price { get; set; }
        public string ProductName { get; set; }
        public string Vehicle { get; set; }
        public decimal ListPrice { get; set; }
        public decimal CostPrice { get; set; }
        public decimal SupplierDiscount { get; set; }
        public decimal FreightCharge { get; set; }
        public decimal CustomerPayment { get; set; }
        public decimal Money { get; set; }
        public int InvoiceDetailId { get; set; }
    }
}