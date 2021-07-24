using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using WEB.Models;
using WebModels;

namespace WEB.WebHelpers
{
    public class RecalculateHelper
    {
        public void RecalculateRevenue(WebContext db, List<InvoiceManageDetail> invoiceManageDetails, List<InvoiceDetailReport> invoiceDetailInMonth)
        {
            foreach (var invoiceManageDetail in invoiceManageDetails)
            {
                var costUnit = (invoiceManageDetail.Money * (decimal)6.5 / 100) / (decimal)invoiceManageDetail.SaleAmount;
                var productInvoiceDetails = invoiceDetailInMonth.Where(x => x.ProductID == invoiceManageDetail.ProductID).OrderBy(y => y.Date);
                var totalSaleQuantityLeft = invoiceManageDetail.SaleAmount;

                var contractInvoiceDetails = productInvoiceDetails.Where(x => x.InvoiceType == "Hợp đồng");

                foreach (var item in contractInvoiceDetails.Where(x => !x.IsProcessed))
                {
                    item.SaleAmountLeft = item.SaleAmount;
                    item.IsProcessed = true;
                }

                var cashInvoiceDetails = productInvoiceDetails.Where(x => x.InvoiceType == "Nợ tiền mặt" || x.InvoiceType == "Tiền mặt");
                foreach (var item in cashInvoiceDetails.Where(x => !x.IsProcessed))
                {
                    item.SaleAmountLeft = item.SaleAmount;
                    item.IsProcessed = true;
                }

                var test = contractInvoiceDetails.Where(x => x.SaleAmountLeft > 0).OrderBy(y => y.Date).ToList();
                // first round: Contract 
                foreach (var productInvoiceDetail in contractInvoiceDetails.Where(x => x.SaleAmountLeft > 0).OrderBy(y => y.Date))
                {
                    if (totalSaleQuantityLeft <= 0)
                    {
                        break;
                    }
                    totalSaleQuantityLeft = totalSaleQuantityLeft - productInvoiceDetail.SaleAmount;
                    productInvoiceDetail.SaleAmountLeft = totalSaleQuantityLeft >= productInvoiceDetail.SaleAmountLeft ? 0 : productInvoiceDetail.SaleAmountLeft - totalSaleQuantityLeft;
                }

                if (totalSaleQuantityLeft <= 0)
                {
                    return;
                }

                // second round: DebtMoney 
                foreach (var productInvoiceDetail in cashInvoiceDetails.Where(x => x.SaleAmountLeft > 0).OrderBy(y => y.Date))
                {
                    if (totalSaleQuantityLeft <= 0)
                    {
                        break;
                    }

                    var invoice = db.Invoices.FirstOrDefault(x => x.ID == productInvoiceDetail.ParrentID);
                    if (!invoice.TotalRevenue.HasValue)
                    {
                        invoice.TotalRevenue = 0;
                    }

                    var quantityToCalculate = totalSaleQuantityLeft >= productInvoiceDetail.SaleAmountLeft ? productInvoiceDetail.SaleAmountLeft : totalSaleQuantityLeft;

                    invoice.TotalRevenue += costUnit * quantityToCalculate;
                    productInvoiceDetail.InvoiceRevenue = costUnit * quantityToCalculate;

                    totalSaleQuantityLeft = totalSaleQuantityLeft - productInvoiceDetail.SaleAmount;
                    productInvoiceDetail.SaleAmountLeft = totalSaleQuantityLeft >= productInvoiceDetail.SaleAmount ? 0 : productInvoiceDetail.SaleAmountLeft - totalSaleQuantityLeft;
                }
            }
        }

        public void CaculateInvoiceRevenue(List<InvoiceManageDetail> invoiceManageDetails, List<InvoiceDetailReport> invoiceDetailReports)
        {
            invoiceDetailReports.ForEach(x => x.InvoiceRevenue = 0);
            invoiceDetailReports.ForEach(x => x.SaleAmountLeft = 0);

            foreach (var productId in invoiceManageDetails.Select(x => x.ProductID).Distinct())
            {
                var invoiceManageDetailsWithProduct = invoiceManageDetails.Where(x => x.ProductID == productId).OrderBy(x => x.Date).ThenBy(x => x.ID);
                var invoiceContractsWithProduct = invoiceDetailReports.Where(x => x.ProductID == productId && x.InvoiceType.Equals("Hợp đồng"));
                var totalContract = invoiceContractsWithProduct.Sum(x => x.SaleAmount);
                if (invoiceManageDetailsWithProduct.Sum(x => x.SaleAmount) <= totalContract)
                    continue;

                decimal totalRemainInvoiceManage = 0;
                foreach (var itemInvoiceManage in invoiceManageDetailsWithProduct)
                {
                    var unitCost = itemInvoiceManage.Money * (decimal)6.5 / 100 / itemInvoiceManage.SaleAmount;
                    var saleAmountManage = itemInvoiceManage.SaleAmount;

                    if (totalContract > 0)
                    {
                        totalContract -= itemInvoiceManage.SaleAmount;
                        continue;
                    };

                    if (totalContract < 0)
                    {
                        saleAmountManage = itemInvoiceManage.SaleAmount - totalContract;
                        totalContract = 0;
                    }

                    var result = UpdateSaleRevenueAmount(invoiceDetailReports, saleAmountManage, unitCost);
                    if (result > 0)
                    {
                        totalRemainInvoiceManage += result * unitCost;
                    }
                }

                if (invoiceDetailReports.Any(x => !x.InvoiceType.Equals("Hợp đồng")))
                {
                    invoiceDetailReports.OrderBy(x => x.Date).ThenBy(x => x.ID).FirstOrDefault(x => !x.InvoiceType.Equals("Hợp đồng")).InvoiceRevenue += totalRemainInvoiceManage;
                }
            }
        }

        private decimal UpdateSaleRevenueAmount(List<InvoiceDetailReport> invoiceOrderDetails, decimal saleAmount, decimal unitCost)
        {
            var remainInvoiceOrder = invoiceOrderDetails.Where(x => !x.InvoiceType.Equals("Hợp đồng") && x.SaleAmountLeft < x.SaleAmount).OrderBy(x => x.Date).ThenBy(x => x.ID);
            if (!remainInvoiceOrder.Any()) return saleAmount;

            foreach (var item in remainInvoiceOrder)
            {
                var remainQuantity = item.SaleAmount - item.SaleAmountLeft;
                if (remainQuantity >= saleAmount)
                {
                    item.SaleAmountLeft += saleAmount;
                    item.InvoiceRevenue += saleAmount * unitCost;
                    return 0; ;
                }

                item.SaleAmountLeft = item.SaleAmount;
                item.InvoiceRevenue += remainQuantity * unitCost;
                saleAmount -= remainQuantity;
            }

            return saleAmount; ;
        }

        public List<InvoiceDetailReport> GetRecalculateCostPrice(WebContext db, int? stationId)
        {
            var invoiceInMonth = db.Invoices.Where(x => (!stationId.HasValue || stationId == 0 || x.StationID == stationId));
            var invoiceIds = invoiceInMonth.Select(x => x.ID);
            var invoiceDetailInMonth = db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive
            && x.InvoiceDetail.Invoice.IsActive
            && (!stationId.HasValue || stationId == 0 || x.StationID == stationId) && invoiceIds.Contains(x.ParrentID)).ToList().OrderBy(x => x.Date).ToList();
            return invoiceDetailInMonth;
        }

        public List<CostPriceResultModel> GetMigrationCostPrice(WebContext db, int productId, int? stationId, InvoiceDetail invoiceDetail)
        {
            var invoiceDetails = db.InvoiceDetails.Where(x => x.IsActive &&
            x.Invoice.IsActive && (!stationId.HasValue || stationId == 0 || x.StationID == stationId)
            && x.ProductID == productId).ToList().OrderBy(x => x.Date).ToList();

            var lstImportOrderState = db.ImportOrderDetails.Where(x => x.IsActive && x.ImportOrder.IsActive && x.ProductID == productId).OrderBy(z => z.Date).Select(y => new ImportOrderDetailState()
            {
                ImportOrderDetail = y,
                QuantityLeft = y.InputNumber
            }).ToList();

            foreach (var item in invoiceDetails)
            {
                var result = GetCostPrice(lstImportOrderState, db, new InvoiceDetail()
                {
                    ProductID = item.ProductID,
                    StationID = item.StationID,
                    SaleAmount = item.SaleAmount
                }, item.Date.Value);

                if (result.Any(x => x.QuantityTaken > 0))
                {
                    item.CostPrice = result.Any() ? result.Sum(x => x.Price * x.QuantityTaken) / result.Sum(y => y.QuantityTaken) : 0;
                }
            }

            // get result 
            var result2 = GetCostPrice(lstImportOrderState, db, new InvoiceDetail()
            {
                ProductID = invoiceDetail.ProductID,
                StationID = invoiceDetail.StationID,
                SaleAmount = invoiceDetail.SaleAmount
            }, invoiceDetail.Date.Value);

            return result2;
        }

        public List<CostPriceResultModel> GetCostPrice(WebContext db, int productId, int? stationId, InvoiceDetail invoiceDetail)
        {
            var invoiceDetails = db.InvoiceDetails.Where(x => x.IsActive &&
            x.Invoice.IsActive && (!stationId.HasValue || stationId == 0 || x.StationID == stationId)
            && x.ProductID == productId).ToList().OrderBy(x => x.Date).ToList();

            var lstImportOrderState = db.ImportOrderDetails.Where(x => x.IsActive && x.ImportOrder.IsActive && x.ProductID == productId).OrderBy(z => z.Date).Select(y => new ImportOrderDetailState()
            {
                ImportOrderDetail = y,
                QuantityLeft = y.InputNumber
            }).ToList();

            foreach (var item in invoiceDetails)
            {
                var result = GetCostPrice(lstImportOrderState, db, new InvoiceDetail()
                {
                    ProductID = item.ProductID,
                    StationID = item.StationID,
                    SaleAmount = item.SaleAmount
                }, item.Date.Value);

                if (result.Any(x => x.QuantityTaken > 0))
                {
                    item.CostPrice = result.Any() ? result.Sum(x => x.Price * x.QuantityTaken) / result.Sum(y => y.QuantityTaken) : 0;
                }
            }

            // get result 
            var result2 = GetCostPrice(lstImportOrderState, db, new InvoiceDetail()
            {
                ProductID = invoiceDetail.ProductID,
                StationID = invoiceDetail.StationID,
                SaleAmount = invoiceDetail.SaleAmount
            }, DateTime.Now);

            return result2;
        }

        public void RecalculateCostPrice(WebContext db, int? stationId)
        {
            var invoiceInMonth = db.Invoices.Where(x => x.IsActive && (!stationId.HasValue || stationId == 0 || x.StationID == stationId));

            var invoiceIds = invoiceInMonth.Select(x => x.ID);
            var invoiceDetails = db.InvoiceDetails.Where(x => x.IsActive
            && x.Invoice.IsActive
            && (!stationId.HasValue || stationId == 0 || x.StationID == stationId) && invoiceIds.Contains(x.ParrentID)).ToList().OrderBy(x => x.Date).ToList();

            var lstImportOrderState = db.ImportOrderDetails.Where(x => x.IsActive && x.ImportOrder.IsActive).OrderBy(z => z.Date).Select(y => new ImportOrderDetailState()
            {
                ImportOrderDetail = y,
                QuantityLeft = y.InputNumber
            }).ToList();

            var dealDetails = db.DealDetails.ToList();
            // create invoice report
            foreach (var invoiceDetail in invoiceDetails)
            {
                if (invoiceDetail.Invoice != null)
                {
                    invoiceDetail.CustomerID = invoiceDetail.Invoice.CustomerID;
                }

                var costPriceResult = GetCostPrice(lstImportOrderState, db, new InvoiceDetail()
                {
                    ProductID = invoiceDetail.ProductID,
                    StationID = invoiceDetail.StationID,
                    SaleAmount = invoiceDetail.SaleAmount
                }, invoiceDetail.Date.Value);

                invoiceDetail.CostPrice = costPriceResult.Any() && costPriceResult.Sum(y => y.QuantityTaken) != 0 ? costPriceResult.Sum(x => x.Price * x.QuantityTaken) / costPriceResult.Sum(y => y.QuantityTaken) : 0;

                db.InvoiceDetailReports.RemoveMany(db.InvoiceDetailReports.Where(x => x.InvoiceDetailId == invoiceDetail.ID));

                foreach (var item in costPriceResult)
                {
                    // calculate freight charge
                    dynamic freightChargeFirst = null;
                    decimal discount = 0;

                    // listed price
                    var joinProduct = from pd in db.Products
                                      where (pd.IsActive && pd.ID == invoiceDetail.ProductID)
                                      join lpr in db.ListedPrices on pd.ID equals lpr.ProductID into group2

                                      from item2 in group2.DefaultIfEmpty()
                                      where (item2.IsActive)
                                      select new
                                      {
                                          TimeApply = item2.TimeApply,
                                          ListedPrice = item2.PriceListed,
                                      };

                    var productJson = joinProduct.Where(x => x.TimeApply <= invoiceDetail.Date)
                        .OrderByDescending(x => x.TimeApply).FirstOrDefault();
                    var listprice = productJson != null ? productJson.ListedPrice : 0;

                    if (item.Price > 0)
                    {
                        discount = listprice - (item.Price * (decimal)1.1);
                        if (discount < 0)
                        {
                            discount = 0;
                        }

                        if (discount > 0)
                        {
                            var freightCharge = from x in dealDetails.Where(x => x.FreightCharges.IsActive)
                                                where (x.IsActive && x.StationID == invoiceDetail.StationID && x.DiscountAmount > discount)
                                                select new { FreightCharge = x.FreightCharge, Discount = x.DiscountAmount };
                            freightChargeFirst = freightCharge.OrderBy(x => x.Discount).FirstOrDefault();
                        }
                    }

                    var invoiceDetailReport = new InvoiceDetailReport()
                    {
                        ParrentID = invoiceDetail.ParrentID,
                        ProductID = invoiceDetail.ProductID,
                        SalePrice = invoiceDetail.SalePrice,
                        ListPrice = listprice,
                        FreightCharge = freightChargeFirst != null ? freightChargeFirst.FreightCharge : 0,
                        CustomerID = invoiceDetail.CustomerID,
                        SupplierDiscount = discount,
                        CustomerPayment = (invoiceDetail.InvoiceType=="Tiền mặt")? item.QuantityTaken * invoiceDetail.SalePrice: invoiceDetail.CustomerPayment,
                        InvoiceRevenue = invoiceDetail.InvoiceRevenue,
                        InvoiceType = invoiceDetail.InvoiceType,
                        Money = item.QuantityTaken * invoiceDetail.SalePrice,
                        StationID = invoiceDetail.StationID,
                        ModifiedAt = DateTime.Now,
                        ModifiedBy = invoiceDetail.ModifiedBy,
                        InvoiceDetailId = invoiceDetail.ID,
                        CostPrice = item.Price,
                        SaleAmount = item.QuantityTaken,
                        CreatedAt = DateTime.Now,
                        CreatedBy = invoiceDetail.CreatedBy,
                        Date = invoiceDetail.Date,
                        IsActive = true
                    };
                    db.InvoiceDetailReports.Add(invoiceDetailReport);
                }
            }

            db.SaveChanges();
        }

        private List<CostPriceResultModel> GetCostPrice(List<ImportOrderDetailState> lstState,
            WebContext db, InvoiceDetail invoiceDetail, DateTime date)
        {
            var result = new List<CostPriceResultModel>();
            var allImportOrders = lstState.Where(x => x.ImportOrderDetail.Date <= date && x.ImportOrderDetail.ProductID == invoiceDetail.ProductID
            && x.ImportOrderDetail.StationID == invoiceDetail.StationID && x.QuantityLeft > 0);
            foreach (var item in allImportOrders)
            {
                if (item.QuantityLeft >= invoiceDetail.SaleAmount)
                {
                    result.Add(new CostPriceResultModel()
                    {
                        ImportOrderId = item.ImportOrderDetail.ID,
                        Price = item.ImportOrderDetail.InputPrice,
                        QuantityTaken = invoiceDetail.SaleAmount
                    });
                    item.QuantityLeft -= invoiceDetail.SaleAmount;
                    break;
                }
                else
                {
                    result.Add(new CostPriceResultModel()
                    {
                        ImportOrderId = item.ImportOrderDetail.ID,
                        Price = item.ImportOrderDetail.InputPrice,
                        QuantityTaken = item.QuantityLeft
                    });

                    invoiceDetail.SaleAmount = invoiceDetail.SaleAmount - item.QuantityLeft;
                    item.QuantityLeft = 0;
                }
            }

            return result;
        }
    }
}