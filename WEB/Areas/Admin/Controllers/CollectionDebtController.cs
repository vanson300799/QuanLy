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
    public class CollectionDebtController : Controller
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
            var model = new CollectionDebtViewModel();
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID ?? default(int);
            }
            return View(model);
        }
        public ActionResult CollectionDebt_Read([DataSourceRequest] DataSourceRequest request, CollectionDebtViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);
            
            var revenueSale = from inv in db.InvoiceDetails.Where(x => x.IsActive == true  && x.Invoice.IsActive
                                   && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.IsActive))
                                   && (model.CustomerID.HasValue ? x.CustomerID == model.CustomerID : x.IsActive)
                                   && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end)
                                   && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start))
                              join customer in db.Customers.Where(x => x.IsActive) on inv.CustomerID equals customer.ID into group1
                              from item1 in group1.DefaultIfEmpty()

                              join station in db.Stations.Where(x => x.IsActive) on inv.StationID equals station.ID into group2
                              from item2 in group2.DefaultIfEmpty()
                              select new CollectionDebtViewModel()
                              {
                                  StationID = inv.StationID,
                                  StationName = item2.StationName,
                                  CustomerID = item1.ID,
                                  CustomerCode = item1.CustomerCode,
                                  CustomerName = item1.CustomerName
                              };
            var list = revenueSale.ToList();
            var listrevenueSale = list.GroupBy(m => new { m.CustomerID, m.CustomerCode, m.CustomerName, m.DateTime, m.StationID })
                        .Select(group => group.First())
                        .ToList();
            
            foreach (var item in listrevenueSale)
            {
                decimal customerpay = 0;
                decimal totalmoney = 0;
                decimal customerpayterm = 0;
                decimal totalmoneyterm = 0;
                decimal customerpaygrow = 0;
                decimal totalmoneygrow = 0;
                var begindebt = from inv in db.InvoiceDetails.Where(x => x.IsActive == true
                                  && x.StationID == item.StationID
                                  && x.CustomerID == item.CustomerID
                                  && DbFunctions.TruncateTime(x.Date) < DbFunctions.TruncateTime(start))
                                select new
                                {
                                    customerPay = inv.Invoice.CustomerPayment.HasValue ? inv.Invoice.CustomerPayment : 0,
                                    totalMoney = inv.Money,
                                };
                var listdebtbegin = begindebt.ToList();

                if (listdebtbegin.Count() != 0)
                {
                    foreach (var begincount in listdebtbegin)
                    {
                        customerpay += (decimal)begincount.customerPay;
                        totalmoney += (decimal)begincount.totalMoney;
                    }
                }
                var debt = db.DebtManages.Where(x => x.IsActive && x.CustomerID == item.CustomerID && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(start)).ToList();
                if (debt.Count() != 0)
                {
                    foreach (var debtitem in debt)
                    {
                        customerpay += (decimal)debtitem.Money;
                    }
                }

                if (customerpay > totalmoney)
                {
                    item.HavePriceBegin = customerpay - totalmoney;
                    item.DebtPriceBegin = 0;
                }
                else
                {
                    item.DebtPriceBegin = totalmoney - customerpay;
                    item.HavePriceBegin = 0;
                }

                var begingrow = from inv in db.InvoiceDetails.Where(x => x.IsActive == true
                                  && x.StationID == item.StationID
                                  && x.CustomerID == item.CustomerID
                                  && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end)
                                  && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start))
                                select new
                                {
                                    customerPay = inv.Invoice.CustomerPayment.HasValue ? inv.Invoice.CustomerPayment : 0,
                                    totalMoney = inv.Money,
                                };

                var begingrowlist = begingrow.ToList();
                if (begingrowlist.Count() != 0)
                {
                    foreach (var growcount in begingrowlist)
                    {
                        customerpaygrow += (decimal)growcount.customerPay;
                        totalmoneygrow += (decimal)growcount.totalMoney;
                    }
                }
                var debtgrow = db.DebtManages.Where(x => x.IsActive && x.CustomerID == item.CustomerID
                && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end)
                && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start)).ToList();

                if (debtgrow.Count() != 0)
                {
                    foreach (var debtitem in debtgrow)
                    {
                        customerpaygrow += (decimal)debtitem.Money;
                    }
                }

                item.HavePriceGrow = customerpaygrow;
                item.DebtPriceGrow = totalmoneygrow;


                customerpayterm = item.HavePriceBegin + item.HavePriceGrow;
                totalmoneyterm = item.DebtPriceBegin + item.DebtPriceGrow;
                if (customerpayterm > totalmoneyterm)
                {
                    item.HavePriceTerm = customerpayterm - totalmoneyterm;
                    item.DebtPriceTerm = 0;
                }
                else
                {
                    item.DebtPriceTerm = totalmoneyterm - customerpayterm;
                    item.HavePriceTerm = 0;
                }
            }

            return Json(listrevenueSale.ToList(), JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(CollectionDebtViewModel model)
        {

            var result = DownloadCollectionDebt(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Tong-hop-cong-no-phai-thu.xlsx");
        }
        public byte[] DownloadCollectionDebt(CollectionDebtViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);

            var revenueSale = from inv in db.InvoiceDetails.Where(x => x.IsActive == true && x.Invoice.IsActive
                                   && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.IsActive))
                                   && (model.CustomerID.HasValue ? x.CustomerID == model.CustomerID : x.IsActive)
                                   && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end)
                                   && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start))
                              join customer in db.Customers.Where(x => x.IsActive) on inv.CustomerID equals customer.ID into group1
                              from item1 in group1.DefaultIfEmpty()

                              join station in db.Stations.Where(x => x.IsActive) on inv.StationID equals station.ID into group2
                              from item2 in group2.DefaultIfEmpty()
                              select new CollectionDebtViewModel()
                              {
                                  StationID = inv.StationID,
                                  StationName = item2.StationName,
                                  CustomerID = item1.ID,
                                  CustomerCode = item1.CustomerCode,
                                  CustomerName = item1.CustomerName
                              };
            var list = revenueSale.ToList();
            var listrevenueSale = list.GroupBy(m => new { m.CustomerID, m.CustomerCode, m.CustomerName, m.DateTime, m.StationID })
                        .Select(group => group.First())
                        .ToList();

            foreach (var item in listrevenueSale)
            {
                decimal customerpay = 0;
                decimal totalmoney = 0;
                decimal customerpayterm = 0;
                decimal totalmoneyterm = 0;
                decimal customerpaygrow = 0;
                decimal totalmoneygrow = 0;
                var begindebt = from inv in db.InvoiceDetails.Where(x => x.IsActive == true
                                  && x.StationID == item.StationID
                                  && x.CustomerID == item.CustomerID
                                  && DbFunctions.TruncateTime(x.Date) < DbFunctions.TruncateTime(start))
                                select new
                                {
                                    customerPay = inv.Invoice.CustomerPayment.HasValue ? inv.Invoice.CustomerPayment : 0,
                                    totalMoney = inv.Money,
                                };
                var listdebtbegin = begindebt.ToList();

                if (listdebtbegin.Count() != 0)
                {
                    foreach (var begincount in listdebtbegin)
                    {
                        customerpay += (decimal)begincount.customerPay;
                        totalmoney += (decimal)begincount.totalMoney;
                    }
                }
                var debt = db.DebtManages.Where(x => x.IsActive && x.CustomerID == item.CustomerID && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(start)).ToList();
                if (debt.Count() != 0)
                {
                    foreach (var debtitem in debt)
                    {
                        customerpay += (decimal)debtitem.Money;
                    }
                }

                if (customerpay > totalmoney)
                {
                    item.HavePriceBegin = customerpay - totalmoney;
                    item.DebtPriceBegin = 0;
                }
                else
                {
                    item.DebtPriceBegin = totalmoney - customerpay;
                    item.HavePriceBegin = 0;
                }

                var begingrow = from inv in db.InvoiceDetails.Where(x => x.IsActive == true
                                  && x.StationID == item.StationID
                                  && x.CustomerID == item.CustomerID
                                  && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end)
                                  && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start))
                                select new
                                {
                                    customerPay = inv.Invoice.CustomerPayment.HasValue ? inv.Invoice.CustomerPayment : 0,
                                    totalMoney = inv.Money,
                                };

                var begingrowlist = begingrow.ToList();
                if (begingrowlist.Count() != 0)
                {
                    foreach (var growcount in begingrowlist)
                    {
                        customerpaygrow += (decimal)growcount.customerPay;
                        totalmoneygrow += (decimal)growcount.totalMoney;
                    }
                }
                var debtgrow = db.DebtManages.Where(x => x.IsActive && x.CustomerID == item.CustomerID
                && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end)
                && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start)).ToList();

                if (debtgrow.Count() != 0)
                {
                    foreach (var debtitem in debtgrow)
                    {
                        customerpaygrow += (decimal)debtitem.Money;
                    }
                }

                item.HavePriceGrow = customerpaygrow;
                item.DebtPriceGrow = totalmoneygrow;


                customerpayterm = item.HavePriceBegin + item.HavePriceGrow;
                totalmoneyterm = item.DebtPriceBegin + item.DebtPriceGrow;
                if (customerpayterm > totalmoneyterm)
                {
                    item.HavePriceTerm = customerpayterm - totalmoneyterm;
                    item.DebtPriceTerm = 0;
                }
                else
                {
                    item.DebtPriceTerm = totalmoneyterm - customerpayterm;
                    item.HavePriceTerm = 0;
                }
            }
            var fileinfo = new FileInfo(string.Format(@"{0}\Tong_hop_cong_no_phai_thu.xlsx", HostingEnvironment.MapPath("/Uploads")));
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    productWorksheet.Select();
                    if (model.StationID.HasValue)
                    {
                        var station = db.Stations.Where(x => x.ID == model.StationID).Select(x => x.StationName).FirstOrDefault();
                        productWorksheet.Cells[3, 1].Value = "Cửa hàng: " + station;
                    }
                    else
                    {
                        productWorksheet.Cells[3, 1].Value = "Cửa hàng: TẤT CẢ";
                    }
                    productWorksheet.Cells[2, 1].Value = " TỪ " + model.Time.ToUpper();
                    var countexcel = listrevenueSale.Count();

                    for (int i = 0; i < countexcel; i++)
                    {
                        var productInfo = listrevenueSale[i];

                        productWorksheet.Cells[i + 6, 1].Value = productInfo.CustomerCode;
                        productWorksheet.Cells[i + 6, 2].Value = productInfo.CustomerName;
                        productWorksheet.Cells[i + 6, 3].Value = productInfo.DebtPriceBegin;
                        productWorksheet.Cells[i + 6, 3].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 6, 4].Value = productInfo.HavePriceBegin;
                        productWorksheet.Cells[i + 6, 4].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 6, 5].Value = productInfo.DebtPriceGrow;
                        productWorksheet.Cells[i + 6, 5].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 6, 6].Value = productInfo.HavePriceGrow;
                        productWorksheet.Cells[i + 6, 6].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 6, 7].Value = productInfo.DebtPriceTerm;
                        productWorksheet.Cells[i + 6, 7].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[i + 6, 8].Value = productInfo.HavePriceTerm;
                        productWorksheet.Cells[i + 6, 8].Style.Numberformat.Format = "#,##0.00";
                    }
                    productWorksheet.Cells[countexcel + 6, 2].Value = "Tổng";
                    productWorksheet.Cells[countexcel + 6, 3].Formula = "=SUM(" + productWorksheet.Cells[6, 3, countexcel + 5, 3] + ")";
                    productWorksheet.Cells[countexcel + 6, 4].Formula = "=SUM(" + productWorksheet.Cells[6, 4, countexcel + 5, 4] + ")";
                    productWorksheet.Cells[countexcel + 6, 5].Formula = "=SUM(" + productWorksheet.Cells[6, 5, countexcel + 5, 5] + ")";
                    productWorksheet.Cells[countexcel + 6, 6].Formula = "=SUM(" + productWorksheet.Cells[6, 6, countexcel + 5, 6] + ")";
                    productWorksheet.Cells[countexcel + 6, 7].Formula = "=SUM(" + productWorksheet.Cells[6, 7, countexcel + 5, 7] + ")";
                    productWorksheet.Cells[countexcel + 6, 8].Formula = "=SUM(" + productWorksheet.Cells[6, 8, countexcel + 5, 8] + ")";

                    productWorksheet.Cells[countexcel + 6, 1, countexcel + 6, 8].Style.Font.Bold = true;
                    productWorksheet.Cells[countexcel + 6, 3].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[countexcel + 6, 4].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[countexcel + 6, 5].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[countexcel + 6, 6].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[countexcel + 6, 7].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[countexcel + 6, 8].Style.Numberformat.Format = "#,##0.00";

                    var modelTable = productWorksheet.Cells[1, 1, countexcel + 6, 8];

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