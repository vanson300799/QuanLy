using Common;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Drawing;
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
    public class DebtWarningController : Controller
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
            var model = new DebtWarningViewModel();
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
        public ActionResult DebtWarning_Read([DataSourceRequest] DataSourceRequest request, DebtWarningViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var dateTime = DateTime.ParseExact(model.TimeString, format, provider);

            var import = (from bd in db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive && x.InvoiceDetail.Invoice.IsActive
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID :( model.StationID.HasValue? x.StationID == model.StationID: x.StationID ==x.StationID))
                         && EntityFunctions.TruncateTime(x.InvoiceDetail.Invoice.Date) <= EntityFunctions.TruncateTime(dateTime.Date)
                         && (x.CustomerPayment - x.Money < 0))
                          join ct in db.Customers on bd.InvoiceDetail.Invoice.CustomerID equals ct.ID into group1

                          from item1 in group1.DefaultIfEmpty()
                          select new DebtWarningViewModel
                          {
                              DateTime = (DateTime)bd.Date,
                              CustomerName = item1.CustomerName,
                              Vehicle = bd.InvoiceDetail.Invoice.Vehicle,
                              Debt = (bd.Money - bd.CustomerPayment),
                              CustomerID = bd.InvoiceDetail.Invoice.CustomerID
                          }).OrderBy(x => x.DateTime).ToList();
            var importDic = from s in import group s by s.CustomerID;
            var test = importDic.ToList();
            var debtManages = from dm in db.DebtManages.Where(x => x.IsActive
                             && EntityFunctions.TruncateTime(x.Date) <= EntityFunctions.TruncateTime(dateTime.Date))
                              select new DebtWarningViewModel
                              {
                                  CustomerID = dm.CustomerID ?? default,
                                  CustomerMoney = dm.Money ?? default
                              };
            var debtDic = debtManages.GroupBy(x => x.CustomerID).ToDictionary(x => x.Key, x => x.Sum(z => z.CustomerMoney));
            List<DebtWarningViewModel> importlist = new List<DebtWarningViewModel>();

            foreach (var items in importDic)
            {
                if (debtDic.TryGetValue(items.Key, out decimal value))
                {
                    decimal moneyRemain = value;
                    foreach (var item in items)
                    {
                        TimeSpan dateSpan = dateTime - item.DateTime;
                        if (moneyRemain != 0)
                        {
                            if (moneyRemain >= item.Debt)
                            {
                                moneyRemain -= item.Debt;
                            }
                            else
                            {
                                DebtWarningViewModel list = new DebtWarningViewModel
                                {
                                    DateTime = item.DateTime,
                                    CustomerName = item.CustomerName,
                                    Vehicle = item.Vehicle,
                                    Debt = item.Debt - moneyRemain,
                                    DebtDate = dateSpan.Days
                                };
                                importlist.Add(list);
                                moneyRemain = 0;
                            }
                        }
                        else
                        {
                            DebtWarningViewModel list = new DebtWarningViewModel
                            {
                                DateTime = item.DateTime,
                                CustomerName = item.CustomerName,
                                Vehicle = item.Vehicle,
                                Debt = item.Debt,
                                DebtDate = dateSpan.Days
                            };
                            importlist.Add(list);
                        }
                    }
                }
                else
                {
                    foreach (var item in items)
                    {
                        TimeSpan dateSpan = dateTime - item.DateTime;
                        DebtWarningViewModel list = new DebtWarningViewModel
                        {
                            DateTime = item.DateTime,
                            CustomerName = item.CustomerName,
                            Vehicle = item.Vehicle,
                            Debt = item.Debt,
                            DebtDate = dateSpan.Days
                        };
                        importlist.Add(list);
                    }
                }
            }
            return Json(importlist, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(DebtWarningViewModel model)
        {
            var result = DownloadDebtWarning(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Canh_bao_no_xau.xlsx");
        }
        public byte[] DownloadDebtWarning(DebtWarningViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var dateTime = DateTime.ParseExact(model.TimeString, format, provider);

            var import = (from bd in db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive && x.InvoiceDetail.Invoice.IsActive
                         && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.StationID == x.StationID))
                         && EntityFunctions.TruncateTime(x.InvoiceDetail.Invoice.Date) <= EntityFunctions.TruncateTime(dateTime.Date)
                         && (x.CustomerPayment - x.Money < 0))
                          join ct in db.Customers on bd.InvoiceDetail.Invoice.CustomerID equals ct.ID into group1

                          from item1 in group1.DefaultIfEmpty()
                          select new DebtWarningViewModel
                          {
                              DateTime = (DateTime)bd.Date,
                              CustomerName = item1.CustomerName,
                              Vehicle = bd.InvoiceDetail.Invoice.Vehicle,
                              Debt = (bd.Money - bd.CustomerPayment),
                              CustomerID = bd.InvoiceDetail.Invoice.CustomerID
                          }).OrderBy(x => x.DateTime).ToList();
            var importDic = from s in import group s by s.CustomerID;
            var test = importDic.ToList();
            var debtManages = from dm in db.DebtManages.Where(x => x.IsActive
                             && EntityFunctions.TruncateTime(x.Date) <= EntityFunctions.TruncateTime(dateTime.Date))
                              select new DebtWarningViewModel
                              {
                                  CustomerID = dm.CustomerID ?? default,
                                  CustomerMoney = dm.Money ?? default
                              };
            var debtDic = debtManages.GroupBy(x => x.CustomerID).ToDictionary(x => x.Key, x => x.Sum(z => z.CustomerMoney));
            List<DebtWarningViewModel> importlist = new List<DebtWarningViewModel>();

            foreach (var items in importDic)
            {
                if (debtDic.TryGetValue(items.Key, out decimal value))
                {
                    decimal moneyRemain = value;
                    foreach (var item in items)
                    {
                        TimeSpan dateSpan = dateTime - item.DateTime;
                        if (moneyRemain != 0)
                        {
                            if (moneyRemain >= item.Debt)
                            {
                                moneyRemain -= item.Debt;
                            }
                            else
                            {
                                DebtWarningViewModel list = new DebtWarningViewModel
                                {
                                    DateTime = item.DateTime,
                                    CustomerName = item.CustomerName,
                                    Vehicle = item.Vehicle,
                                    Debt = item.Debt - moneyRemain,
                                    DebtDate = dateSpan.Days
                                };
                                importlist.Add(list);
                                moneyRemain = 0;
                            }
                        }
                        else
                        {
                            DebtWarningViewModel list = new DebtWarningViewModel
                            {
                                DateTime = item.DateTime,
                                CustomerName = item.CustomerName,
                                Vehicle = item.Vehicle,
                                Debt = item.Debt,
                                DebtDate = dateSpan.Days
                            };
                            importlist.Add(list);
                        }
                    }
                }
                else
                {
                    foreach (var item in items)
                    {
                        TimeSpan dateSpan = dateTime - item.DateTime;
                        DebtWarningViewModel list = new DebtWarningViewModel
                        {
                            DateTime = item.DateTime,
                            CustomerName = item.CustomerName,
                            Vehicle = item.Vehicle,
                            Debt = item.Debt,
                            DebtDate = dateSpan.Days
                        };
                        importlist.Add(list);
                    }
                }
            }
            var fileinfo = new FileInfo(string.Format(@"{0}\DebtWarning.xlsx", HostingEnvironment.MapPath("/Uploads")));
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    productWorksheet.Select();
                    productWorksheet.Cells[1, 1].Value = "CẢNH BÁO NỢ XẤU";
                    if (model.StationID.HasValue)
                    {
                        var station = db.Stations.Where(x => x.ID == model.StationID).Select(x => x.StationName).FirstOrDefault();
                        productWorksheet.Cells[2, 1].Value = "Cửa hàng: " + station;
                    }
                    else
                    {
                        productWorksheet.Cells[2, 1].Value = "Cửa hàng: TẤT CẢ";
                    }
                    productWorksheet.Cells[3, 1].Value = " Ngày " + model.TimeString.ToUpper();
                    var count = importlist.Count();
                    var modelTable = productWorksheet.Cells[1, 1, count + 5, 5];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;

                    for (int i = 0; i < count; i++)
                    {
                        var productInfo = importlist[i];
                        productWorksheet.Cells[i + 6, 1].Value = productInfo.DateTime;
                        productWorksheet.Cells[i + 6, 2].Value = productInfo.CustomerName;
                        productWorksheet.Cells[i + 6, 3].Value = productInfo.Vehicle;
                        productWorksheet.Cells[i + 6, 4].Value = productInfo.Debt;
                        productWorksheet.Cells[i + 6, 5].Value = productInfo.DebtDate;

                        if (productInfo.DebtDate >= 45 && productInfo.DebtDate <= 59)
                        {
                            productWorksheet.Cells[i + 6, 1, i + 6, 5].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            productWorksheet.Cells[i + 6, 1, i + 6, 5].Style.Fill.BackgroundColor.SetColor(Color.Yellow);
                        }
                        else if (productInfo.DebtDate >= 60)
                        {
                            productWorksheet.Cells[i + 6, 1, i + 6, 5].Style.Fill.PatternType = ExcelFillStyle.Solid;
                            productWorksheet.Cells[i + 6, 1, i + 6, 5].Style.Fill.BackgroundColor.SetColor(Color.Red);
                        }

                        productWorksheet.Cells[i + 6, 4].Style.Numberformat.Format = "#,##0.00";
                    }
                    return p.GetAsByteArray();
                }
            }

            return null;
        }
    }
}