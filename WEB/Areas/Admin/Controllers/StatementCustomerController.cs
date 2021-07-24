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
    public class StatementCustomerController : Controller
    {
        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        // GET: Admin/StatementCustomer
        public ActionResult Index()
        {
            var model = new StatementCustomerViewModel();
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID && x.IsActive).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID;
            }
            return View(model);
        }

        public JsonResult StatementCustomerRead(StatementCustomer model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            DateTime timeStart = DateTime.ParseExact(model.StartTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            DateTime timeEnd = DateTime.ParseExact(model.EndTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);

            var listcustomer = from imp in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID )
                                && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd)
                                && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart))
                               join cus in db.Customers.Where(x => x.IsActive) on imp.Invoice.CustomerID equals cus.ID
                               select new CustomerGeneralModel
                               {
                                   CustomerID = imp.Invoice.CustomerID,
                                   StationID = imp.StationID,
                                   CustomerName = cus.CustomerName,
                                   DateTime = imp.Date,
                               };
            var list = listcustomer.ToList();
            var listdis = list.GroupBy(m => new { m.CustomerID, m.StationID, m.CustomerName })
                        .Select(group => group.First())
                        .ToList();

            foreach (var item in listdis)
            {
                var productList = db.ImportOrderDetails.Where(x => x.IsActive && x.ImportOrder.IsActive && x.StationID == item.StationID).ToList();
                List<int> productIDList = new List<int>();
                foreach (var product in productList)
                {
                    productIDList.Add(product.ProductID);
                }
                var productListID = productIDList.Distinct().ToList();
                List<ListProductReportCustomer> listProductReportCustomers = new List<ListProductReportCustomer>();
                foreach (var productID in productListID)
                {
                    var producInfo = from inovice in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive && x.ProductID == productID 
                                     && x.StationID == item.StationID
                                     && x.Invoice.CustomerID == item.CustomerID
                                     && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd)
                                     && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart))
                                     join product in db.Products.Where(x => x.IsActive && x.ID == productID) on inovice.ProductID equals product.ID
                                     select new ListProductReportCustomer
                                     {
                                         ProductID = inovice.ProductID,
                                         ProductCode = product.ProductCode,
                                         ProductName = product.ProductName,
                                         ProductMoney = inovice.Money,
                                         ProductSaleAmount = inovice.SaleAmount
                                     };
                    var infoList = producInfo.ToList();
                    if (infoList.Count() == 0)
                    {
                        var productnull = from prod in db.Products.Where(x => x.IsActive && x.ID == productID)
                                          select new ListProductReportCustomer
                                          {
                                              ProductID = prod.ID,
                                              ProductCode = prod.ProductCode,
                                              ProductName = prod.ProductName,
                                              ProductMoney = 0,
                                              ProductSaleAmount = 0,
                                          };
                        var info = productnull.FirstOrDefault();
                        listProductReportCustomers.Add(info);
                    }
                    else
                    {
                        ListProductReportCustomer info = new ListProductReportCustomer() {
                            ProductCode = infoList.FirstOrDefault().ProductCode,
                            ProductName = infoList.FirstOrDefault().ProductName,
                            ProductID = infoList.FirstOrDefault().ProductID,
                            ProductMoney = infoList.Sum(x => x.ProductMoney),
                            ProductSaleAmount = infoList.Sum(x => x.ProductSaleAmount),
                        };
                        listProductReportCustomers.Add(info);
                    }

                }

                item.listProductReportCustomers = listProductReportCustomers;
            }
            var result = listdis;
            if (result.Count() == 0)
            {
                return Json(new { message = "Không có khách hàng và sản phẩm nào của cửa hàng này hoặc thời gian này!" }, JsonRequestBehavior.AllowGet);
            }

            return Json(result, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(StatementCustomerViewModel model)
        {
            var result = DownloadStatementCustomer(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Bang_ke_tong_hop_khach_hang.xlsx");
        }
        public byte[] DownloadStatementCustomer(StatementCustomerViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            DateTime timeStart = DateTime.ParseExact(model.StartTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            DateTime timeEnd = DateTime.ParseExact(model.EndTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);

            var listcustomer = from imp in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.IsActive))
                                && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd)
                                && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart))
                               join cus in db.Customers.Where(x => x.IsActive) on imp.CustomerID equals cus.ID
                               select new CustomerGeneralModel
                               {
                                   CustomerID = imp.CustomerID,
                                   StationID = imp.StationID,
                                   CustomerName = cus.CustomerName,
                                   DateTime = imp.Date
                               };
            var list = listcustomer.ToList();
            var listdis = list.GroupBy(m => new { m.CustomerID, m.StationID, m.CustomerName })
                        .Select(group => group.First())
                        .ToList();

            foreach (var item in listdis)
            {
                var productList = db.ImportOrderDetails.Where(x => x.IsActive && x.ImportOrder.IsActive && x.StationID == item.StationID).ToList();
                List<int> productIDList = new List<int>();
                foreach (var product in productList)
                {
                    productIDList.Add(product.ProductID);
                }
                var productListID = productIDList.Distinct().ToList();
                List<ListProductReportCustomer> listProductReportCustomers = new List<ListProductReportCustomer>();
                foreach (var productID in productListID)
                {
                    var producInfo = from inovice in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive && x.ProductID == productID
                                     && x.StationID == item.StationID
                                     && x.CustomerID == item.CustomerID
                                     && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd)
                                     && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart))
                                     join product in db.Products.Where(x => x.IsActive && x.ID == productID) on inovice.ProductID equals product.ID
                                     select new ListProductReportCustomer
                                     {
                                         ProductID = inovice.ProductID,
                                         ProductCode = product.ProductCode,
                                         ProductName = product.ProductName,
                                         ProductMoney = inovice.Money,
                                         ProductSaleAmount = inovice.SaleAmount
                                     };
                    var infoList = producInfo.ToList();
                    if (infoList.Count() == 0)
                    {
                        var productnull = from prod in db.Products.Where(x => x.IsActive && x.ID == productID)
                                          select new ListProductReportCustomer
                                          {
                                              ProductID = prod.ID,
                                              ProductCode = prod.ProductCode,
                                              ProductName = prod.ProductName,
                                              ProductMoney = 0,
                                              ProductSaleAmount = 0,
                                          };
                        var info = productnull.FirstOrDefault();
                        listProductReportCustomers.Add(info);
                    }
                    else
                    {
                        ListProductReportCustomer info = new ListProductReportCustomer()
                        {
                            ProductCode = infoList.FirstOrDefault().ProductCode,
                            ProductName = infoList.FirstOrDefault().ProductName,
                            ProductID = infoList.FirstOrDefault().ProductID,
                            ProductMoney = infoList.Sum(x => x.ProductMoney),
                            ProductSaleAmount = infoList.Sum(x => x.ProductSaleAmount),
                        };
                        listProductReportCustomers.Add(info);
                    }

                }

                item.listProductReportCustomers = listProductReportCustomers;
            }
            var result = listdis;
            foreach (var item in result)
            {
                item.Date = item.DateTime.ToString();
            }
            var fileinfo = new FileInfo(string.Format(@"{0}\StatementCustomer.xlsx", HostingEnvironment.MapPath("/Uploads")));
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    var stationex = db.Stations.Where(x => x.ID == model.StationID).FirstOrDefault();
                    productWorksheet.Select();
                    productWorksheet.Cells[1, 1].Value = "BẢNG KÊ TỔNG HỢP KHÁCH HÀNG ";
                    productWorksheet.Cells[2, 1].Value = stationex.StationName.ToUpper();
                    productWorksheet.Cells[3, 1].Value = " TỪ " + model.Time.ToUpper();
                    productWorksheet.Cells[1, 1].Style.Font.Bold = true;
                    productWorksheet.Cells[2, 1].Style.Font.Bold = true;
                    productWorksheet.Cells[3, 1].Style.Font.Italic = true;
                    var productNumber = 0;
                    if (result.Count() != 0)
                    {
                        productNumber = result[0].listProductReportCustomers.Count();
                    }
                    //meger row 1,2,3
                    productWorksheet.Cells[1, 1, 1, productNumber * 2 + 3].Merge = true;
                    productWorksheet.Cells[2, 1, 2, productNumber * 2 + 3].Merge = true;
                    productWorksheet.Cells[3, 1, 3, productNumber * 2 + 3].Merge = true;

                    //TONG col
                    productWorksheet.Cells[4, productNumber * 2 + 3].Style.Font.Bold = true;
                    var modelTable = productWorksheet.Cells[1, 1, result.Count() + 6, productNumber * 2 + 3];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;


                    for (var j = 0; j < result.Count(); j++)
                    {
                        var formulaTotal = "=SUM(";
                        var statementCustomer = result[j];
                        productWorksheet.Cells[j + 6, 1].Value = j + 1;
                        productWorksheet.Cells[j + 6, 2].Value = statementCustomer.CustomerName;

                        for (var i = 0; i < productNumber; i++)
                        {
                            var productInfo = (statementCustomer.listProductReportCustomers)[i];
                            productWorksheet.Cells[4, 3 + i * 2].Value = productInfo.ProductName;
                            productWorksheet.Cells[4, 3 + i * 2].Style.Font.Bold = true;
                            productWorksheet.Cells[4, 3 + i * 2, 4, 4 + i * 2].Merge = true;

                            productWorksheet.Cells[5, 3 + i * 2].Value = "Số lượng";
                            productWorksheet.Cells[5, 4 + i * 2].Value = "Thành tiền";
                            productWorksheet.Cells[5, 3 + i * 2].Style.Font.Bold = true;
                            productWorksheet.Cells[5, 4 + i * 2].Style.Font.Bold = true;

                            productWorksheet.Cells[j + 6, 3 + i * 2].Value = productInfo.ProductSaleAmount;
                            productWorksheet.Cells[j + 6, 4 + i * 2].Value = productInfo.ProductMoney;
                            productWorksheet.Cells[j + 6, 3 + i * 2].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[j + 6, 4 + i * 2].Style.Numberformat.Format = "#,##0.00";

                            productWorksheet.Cells[6 + result.Count(), 3 + i * 2].Formula = "=SUM(" + productWorksheet.Cells[6, 3 + i * 2, j + 6, 3 + i * 2] + ")";
                            productWorksheet.Cells[6 + result.Count(), 4 + i * 2].Formula = "=SUM(" + productWorksheet.Cells[6, 4 + i * 2, j + 6, 4 + i * 2] + ")";

                            productWorksheet.Cells[6 + result.Count(), 3 + i * 2].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[6 + result.Count(), 4 + i * 2].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[6 + result.Count(), 3 + i * 2].Style.Font.Bold = true;
                            productWorksheet.Cells[6 + result.Count(), 4 + i * 2].Style.Font.Bold = true;

                            formulaTotal += productWorksheet.Cells[j + 6, 4 + i * 2] + ",";
                        }
                        productWorksheet.Cells[j + 6, productNumber * 2 + 3].Formula = formulaTotal + ")";
                        productWorksheet.Cells[j + 6, productNumber * 2 + 3].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[j + 6, productNumber * 2 + 3].Style.Font.Bold = true;
                    }
                    //Value Total ROW
                    productWorksheet.Cells[4, productNumber * 2 + 3].Value = "TỔNG";
                    productWorksheet.Cells[4, productNumber * 2 + 3].Style.Font.Bold = true;
                    productWorksheet.Cells[4, productNumber * 2 + 3, 5, productNumber * 2 + 3].Merge = true;

                    //Value Total COL
                    productWorksheet.Cells[6 + result.Count(), 2].Value = "TỔNG";
                    productWorksheet.Cells[6 + result.Count(), productNumber * 2 + 2].Formula = "=SUM(" + productWorksheet.Cells[6, productNumber * 2 + 2, 5 + result.Count(), productNumber * 2 + 2] + ")";
                    productWorksheet.Cells[6 + result.Count(), productNumber * 2 + 3].Formula = "=SUM(" + productWorksheet.Cells[6, productNumber * 2 + 3, 5 + result.Count(), productNumber * 2 + 3] + ")";
                    productWorksheet.Cells[6 + result.Count(), productNumber * 2 + 2].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[6 + result.Count(), productNumber * 2 + 3].Style.Numberformat.Format = "#,##0.00";
                    productWorksheet.Cells[6 + result.Count(), 2].Style.Font.Bold = true;
                    productWorksheet.Cells[6 + result.Count(), productNumber * 2 + 2].Style.Font.Bold = true;
                    productWorksheet.Cells[6 + result.Count(), productNumber * 2 + 3].Style.Font.Bold = true;
                    return p.GetAsByteArray();
                }
            }

            return null;
        }
    }
}