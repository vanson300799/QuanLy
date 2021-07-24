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
    public class DetailCommissionController : Controller
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
            var model = new DetailCommissionViewModel();
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID;
            }
            return View(model);
        }
        public ActionResult DetailCommission_Read([DataSourceRequest] DataSourceRequest request, DetailCommissionViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);

            var import = from ind in db.InvoiceDetails.Where(x => x.IsActive 
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                         && x.InvoiceType == "Hợp đồng"
                         && EntityFunctions.TruncateTime(x.Date) <= EntityFunctions.TruncateTime(end) 
                         && EntityFunctions.TruncateTime(x.Date) >= EntityFunctions.TruncateTime(start))
                         join ct in db.Customers on ind.Invoice.CustomerID equals ct.ID into group1

                         from item1 in group1.DefaultIfEmpty()
                         select new DetailCommissionViewModel
                         {
                             DateTime = (DateTime)ind.Date,
                             CustomerCode = item1.CustomerCode,
                             Note = ind.Invoice.Note,
                             SaleAmount = ind.SaleAmount,
                         };
            var countlist = 1;
            List<DetailCommissionViewModel> importlist = new List<DetailCommissionViewModel>();

            foreach (var item in import)
            {
                var discount = db.Commissions.OrderByDescending(x => x.TimeApply).FirstOrDefault(x => x.IsActive && x.TimeApply <= item.DateTime);
                DetailCommissionViewModel list = new DetailCommissionViewModel
                {
                    Count = countlist,
                    CustomerCode = item.CustomerCode,
                    DateTime = item.DateTime,
                    Note = item.Note,
                    SaleAmount = item.SaleAmount,
                    Discount = (decimal) discount.CommissionRate,
                    Money = item.SaleAmount * (decimal) discount.CommissionRate
                };

                countlist += 1;
                importlist.Add(list);
            }
            return Json(importlist, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(DetailCommissionViewModel model)
        {
            var result = DownloadDetailCommission(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Hoa_hong_theo_cua_hang.xlsx");
        }
        public byte[] DownloadDetailCommission(DetailCommissionViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);

            var import = from ind in db.InvoiceDetails.Where(x => x.IsActive
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                         && x.InvoiceType == "Hợp đồng"
                         && EntityFunctions.TruncateTime(x.Date) <= EntityFunctions.TruncateTime(end)
                         && EntityFunctions.TruncateTime(x.Date) >= EntityFunctions.TruncateTime(start))
                         join ct in db.Customers on ind.Invoice.CustomerID equals ct.ID into group1

                         from item1 in group1.DefaultIfEmpty()
                         select new DetailCommissionViewModel
                         {
                             DateTime = (DateTime)ind.Date,
                             CustomerCode = item1.CustomerCode,
                             Note = ind.Invoice.Note,
                             SaleAmount = ind.SaleAmount,
                         };
            var countlist = 1;
            List<DetailCommissionViewModel> importlist = new List<DetailCommissionViewModel>();

            foreach (var item in import)
            {
                var discount = db.Commissions.OrderByDescending(x => x.TimeApply).FirstOrDefault(x => x.IsActive && x.TimeApply <= item.DateTime);
                DetailCommissionViewModel list = new DetailCommissionViewModel
                {
                    Count = countlist,
                    CustomerCode = item.CustomerCode,
                    DateTime = item.DateTime,
                    Note = item.Note,
                    SaleAmount = item.SaleAmount,
                    Discount = (decimal)discount.CommissionRate,
                    Money = item.SaleAmount * (decimal)discount.CommissionRate
                };

                countlist += 1;
                importlist.Add(list);
            }
            var fileinfo = new FileInfo(string.Format(@"{0}\DetailCommission.xlsx", HostingEnvironment.MapPath("/Uploads")));
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    var station = db.Stations.Where(x => x.ID == model.StationID).FirstOrDefault();
                    productWorksheet.Select();
                    productWorksheet.Cells[1, 1].Value = "BẢNG CHI TIẾT PHÁT HOA HỒNG CỬA HÀNG " + station.StationName.ToUpper() + " TỪ " + model.Time.ToUpper();
                    var count = import.Count();

                    var modelTable = productWorksheet.Cells[1, 1, count + 4, 7];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    for (int i = 0; i < count; i++)
                    {
                        var productInfo = importlist[i];
                        productWorksheet.Cells[i + 3, 1].Value = productInfo.Count;
                        productWorksheet.Cells[i + 3, 2].Value = productInfo.DateTime;
                        productWorksheet.Cells[i + 3, 3].Value = productInfo.CustomerCode;
                        productWorksheet.Cells[i + 3, 4].Value = productInfo.SaleAmount;
                        productWorksheet.Cells[i + 3, 5].Value = productInfo.Discount;
                        productWorksheet.Cells[i + 3, 6].Value = productInfo.Money;
                        productWorksheet.Cells[i + 3, 7].Value = productInfo.Note;

                        productWorksheet.Cells[i + 3, 4].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 3, 5].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 3, 6].Style.Numberformat.Format = "#,##0.00";
                    }

                    productWorksheet.Cells[count + 4, 2, count + 4, 3].Merge = true;
                    productWorksheet.Cells[count + 4, 2].Value = "TỔNG";
                    productWorksheet.Cells[count + 4, 4].Formula = "=SUM(" + productWorksheet.Cells[3, 4, count + 2, 4] + ")";
                    productWorksheet.Cells[count + 4, 6].Formula = "=SUM(" + productWorksheet.Cells[3, 6, count + 2, 6] + ")";

                    productWorksheet.Cells[count + 4, 4].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[count + 4, 6].Style.Numberformat.Format = "#,##0.00";

                    productWorksheet.Cells[count + 4, 1, count + 4, 7].Style.Font.Bold = true;
                    return p.GetAsByteArray();
                }
            }

            return null;
        }
    }
}