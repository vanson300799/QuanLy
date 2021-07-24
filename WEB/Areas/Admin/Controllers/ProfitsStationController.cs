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
    public class ProfitsStationController : Controller
    {
        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        // GET: Admin/ProfitsStation
        public ActionResult Index()
        {
            var model = new ProfitsStationViewModel();
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
        public ActionResult ProfitsStation_Read([DataSourceRequest] DataSourceRequest request, ProfitsStationViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);
            TimeSpan ts = new TimeSpan(0, 0, 0);
            TimeSpan ts1 = new TimeSpan(24, 0, 0);
            var endspan = end.Date + ts1;
            var startspan = start.Date + ts;
            TimeSpan amountTime = endspan - startspan;
            //tổng số ngày
            int amountDays = amountTime.Days;

            var import = from idr in db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive
                              && x.InvoiceDetail.Invoice.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                         && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end) && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start))
                         join iv in db.Invoices on idr.ParrentID equals iv.ID into group1

                         from item1 in group1.DefaultIfEmpty()
                         join st in db.Stations on idr.StationID equals st.ID into group2

                         from item2 in group2.DefaultIfEmpty()
                         select new ProfitsStationViewModel
                         {
                             DateTime = (DateTime)idr.Date,
                             Amount = idr.SaleAmount,
                             Revenue = idr.SaleAmount * (idr.ListPrice / (decimal)1.1) - (idr.CostPrice * idr.SaleAmount),
                             HandleInvoice = idr.InvoiceRevenue,
                             CostHandleInvoice = idr.InvoiceRevenue,
                             //Discount = idr.ListPrice - idr.SalePrice,
                             //Commission = idr.InvoiceDetail.SaleAmount,
                             Freight = idr.FreightCharge * idr.SaleAmount,
                             WorkingCaptial = (idr.InvoiceDetail.InvoiceType == "Nợ tiền mặt") ? ((idr.CostPrice * (decimal)1.1 * idr.SaleAmount - idr.CustomerPayment)* (decimal)1.3 + (decimal)0.3 * idr.CustomerPayment):
                             ((idr.InvoiceDetail.InvoiceType == "Hợp đồng")? (idr.CostPrice * (decimal)1.1 * idr.SaleAmount * (decimal)1.65)
                             :(idr.CostPrice * (decimal)1.1 * idr.SaleAmount * (decimal)0.3))
                         };
            var invoiceDetail = from id in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive
                                && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                                && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end) && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start))

                                select new ProfitsStationViewModel
                                {
                                    DateTime = (DateTime)id.Date,
                                    Discount = id.ListPrice - id.SalePrice,
                                    InvoiceType = id.InvoiceType,
                                    Amount = id.SaleAmount
                                };

            decimal oilImportMoney = 0;
            decimal electricPhoneMoney = 0;
            decimal customerServiceMoney = 0;
            decimal promotionMoney = 0;
            decimal laborMoney = 0;
            decimal costReturnCompanyMoney = 0;
            var dayOfMonthCompany = 0;
            var dayOfMonthLabor = 0;
            var costManages = db.CostManages.Where(x =>x.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                    && x.StationID == model.StationID && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end)).ToList();
            //Đơn vị chi phí
            //Dầu nhập
            var oilImport = costManages.Where(x => x.Note == WebResources.OilImportCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (oilImport != null)
            {
                oilImportMoney = oilImport.Money ?? default;
            }
            //Điện, điện thoại
            var electricPhone = costManages.Where(x => x.Note == WebResources.ElectricPhoneCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (electricPhone != null)
            {
                electricPhoneMoney = electricPhone.Money ?? default;
            }
            //Chăm sóc khách hàng
            var customerService = costManages.Where(x => x.Note == WebResources.CustomerServiceCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (customerService != null)
            {
                customerServiceMoney = customerService.Money ?? default;
            }
            //Khuyến mại
            var promotion = costManages.Where(x => x.Note == WebResources.PromotionCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (promotion != null)
            {
                promotionMoney = promotion.Money ?? default;
            }
            //Nhân công theo quy chế
            var labor = costManages.Where(x => x.Note == WebResources.LaborCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (labor != null)
            {
                laborMoney = labor.Money ?? default;
                var dateLabor = (DateTime)labor.Date;
                dayOfMonthLabor = System.DateTime.DaysInMonth(dateLabor.Year, dateLabor.Month);
            }
            //Chi phí nộp lại công ty
            var costReturnCompany = costManages.Where(x => x.Note == WebResources.CostReturnCompanyCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (costReturnCompany != null)
            {
                costReturnCompanyMoney = costReturnCompany.Money ?? default;
                var dateCompany = (DateTime)costReturnCompany.Date;
                dayOfMonthCompany = System.DateTime.DaysInMonth(dateCompany.Year, dateCompany.Month);
            }
            var countlist = 1;
            List<ProfitsStationViewModel> importlist = new List<ProfitsStationViewModel>();
            List<ProfitsStationViewModel> invoiceCommission = new List<ProfitsStationViewModel>();
            List<ProfitsStationViewModel> invoiceDiscount = new List<ProfitsStationViewModel>();
            var checkStation = false;
            decimal? costHanldeIncrease = 0;
            var station = db.Stations.Where(x => x.ID == model.StationID).FirstOrDefault();
            if (station.StationName == "Phao dầu 1")
            {
                if(import.ToList().Count != 0)
                {
                    var station1 = db.Stations.Where(x => x.IsActive && x.StationName == "Phao dầu 2").Select(x => x.ID).FirstOrDefault();
                    var station2 = db.Stations.Where(x => x.IsActive && x.StationName == "Phao dầu 3").Select(x => x.ID).FirstOrDefault();
                    costHanldeIncrease = db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive
                             && x.InvoiceDetail.Invoice.IsActive && (x.StationID == station1 || x.StationID == station2)
                             && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end) && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start)).Sum(x => x.InvoiceRevenue);
                    costHanldeIncrease = (costHanldeIncrease * 5) / 100;
                }
                checkStation = true;
            }

            foreach (var item in import)
            {
                ProfitsStationViewModel list = new ProfitsStationViewModel
                {
                    DateTime = item.DateTime,
                    Amount = item.Amount,
                    Revenue = item.Revenue,
                    HandleInvoice = item.HandleInvoice.HasValue ? item.HandleInvoice : 0,
                    CostHandleIncrease = checkStation ? costHanldeIncrease : null,
                    CostHandleInvoice = checkStation ? 0: (item.CostHandleInvoice.HasValue ? (5 * item.CostHandleInvoice) / 100 : 0),
                    Freight = item.Freight,
                    WorkingCaptial = item.WorkingCaptial,
                };
                countlist += 1;
                importlist.Add(list);
            }
            foreach (var item in invoiceDetail)
            {
                if (item.InvoiceType == "Hợp đồng")
                {
                    decimal commissionRate = 0;
                    var commission = db.Commissions.OrderByDescending(x => x.TimeApply).FirstOrDefault(x => x.IsActive && x.TimeApply <= item.DateTime);
                    if (commission != null)
                    {
                        commissionRate = item.Amount * commission.CommissionRate ?? default;
                    }
                    ProfitsStationViewModel list = new ProfitsStationViewModel
                    {
                        Commission = commissionRate,
                    };
                    invoiceCommission.Add(list);
                }
                else
                {
                    ProfitsStationViewModel list = new ProfitsStationViewModel
                    {
                        Discount = item.Discount * item.Amount,
                    };
                    invoiceDiscount.Add(list);
                }
            }

            ProfitsStationViewModel profitItem = new ProfitsStationViewModel
            {
                StationName = station.StationName,
                //=============== Invoice Detail================================
                Discount = invoiceDiscount.Sum(x => x.Discount),
                Commission = invoiceCommission.Sum(x => x.Commission),
                //==================Invoice Detail Report==============================
                Amount = importlist.Sum(x => x.Amount),
                Revenue = importlist.Sum(x => x.Revenue),
                HandleInvoice = importlist.Sum(x => x.HandleInvoice),
                CostHandleIncrease = checkStation ? costHanldeIncrease : null,
                CostHandleInvoice = checkStation ? 0 : importlist.Sum(x => x.CostHandleInvoice),
                Freight = importlist.Sum(x => x.Freight),
                OilImport = importlist.Sum(x => x.Amount) * oilImportMoney,
                ElectricPhone = importlist.Sum(x => x.Amount) * electricPhoneMoney,
                CustomerService = importlist.Sum(x => x.Amount) * customerServiceMoney,
                Promotion = importlist.Sum(x => x.Amount) * promotionMoney,
                WorkingCaptial = (importlist.Sum(x => x.WorkingCaptial) * 12 / 100) / 365 * amountDays,
                Labor = importlist.Sum(x => x.Amount) * ((dayOfMonthLabor != 0) ? (laborMoney / dayOfMonthLabor) : 0) * amountDays,
                CostReturnCompany = importlist.Sum(x => x.Amount) * ((dayOfMonthCompany != 0) ? (costReturnCompanyMoney / dayOfMonthCompany) : 0) * amountDays,
            };
            profitItem.CostStationPayment = (decimal)(profitItem.CostHandleInvoice + profitItem.Discount + profitItem.Commission + profitItem.Freight + profitItem.OilImport
                + profitItem.ElectricPhone + profitItem.CustomerService + profitItem.Promotion + profitItem.WorkingCaptial + profitItem.Labor);
            profitItem.RemainingProfit = (decimal)(profitItem.Revenue + profitItem.HandleInvoice - profitItem.CostStationPayment - profitItem.CostReturnCompany);

            return Json(GenerateProfitList(profitItem), JsonRequestBehavior.AllowGet);
        }

        private List<ProfitGridItem> GenerateProfitList(ProfitsStationViewModel profitItem)
        {
            var resultList = new List<ProfitGridItem>();

            resultList.Add(new ProfitGridItem()
            {
                No = "A",
                Content = "Sản lượng",
                Amount = profitItem.Amount,
                Unit = "lít"
            });

            resultList.Add(new ProfitGridItem()
            {
                No = "B",
                Content = "Doanh thu",
                Amount = profitItem.Revenue,
                Unit = "đồng"
            });

            resultList.Add(new ProfitGridItem()
            {
                No = "C",
                Content = "Xử lý hóa đơn",
                Amount = profitItem.HandleInvoice.HasValue ? profitItem.HandleInvoice.Value : 0
            });
            if (profitItem.StationName=="Phao dầu 1")
            {
                resultList.Add(new ProfitGridItem()
                {
                    No = "D",
                    Content = "Chi phí xử lý tăng thêm",
                    Amount = profitItem.CostHandleIncrease.HasValue ? profitItem.CostHandleIncrease.Value : 0
                });
            }
            resultList.Add(new ProfitGridItem()
            {
                No = "I",
                Content = "Chi phí cửa hàng phải chi trả",
                Amount = profitItem.CostStationPayment
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "1",
                Content = "Chi phí xử lý hoá đơn",
                Amount = profitItem.CostHandleInvoice.HasValue? profitItem.CostHandleInvoice.Value:0
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "2",
                Content = "Chiết khấu",
                Amount = profitItem.Discount
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "3",
                Content = "Hoa hồng",
                Amount = profitItem.Commission
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "4",
                Content = "Vận chuyển",
                Amount = profitItem.Freight
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "5",
                Content = "Dầu nhập",
                Amount = profitItem.OilImport
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "6",
                Content = "Điện, điện thoại",
                Amount = profitItem.ElectricPhone
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "7",
                Content = "Chăm sóc khách hàng",
                Amount = profitItem.CustomerService
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "8",
                Content = "Khuyến mại",
                Amount = profitItem.Promotion
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "9",
                Content = "CPTC vốn lưu động",
                Amount = profitItem.WorkingCaptial
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "10",
                Content = "Nhân công theo quy chế",
                Amount = profitItem.Labor
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "II",
                Content = "Chi phí nộp lại công ty",
                Amount = profitItem.CostReturnCompany
            });
            resultList.Add(new ProfitGridItem()
            {
                No = "III",
                Content = "Lợi nhuận còn lại",
                Amount = profitItem.RemainingProfit
            });
            return resultList;
        }

        public class ProfitGridItem
        {
            public string No { get; set; }

            public string Content { get; set; }

            public decimal Amount { get; set; }

            public string Unit { get; set; }
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(ProfitsStationViewModel model)
        {
            var result = DownloadCostIncurred(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Loi_nhuan_cua_hang.xlsx");
        }
        public byte[] DownloadCostIncurred(ProfitsStationViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);

            TimeSpan ts = new TimeSpan(0, 0, 0);
            TimeSpan ts1 = new TimeSpan(24, 0, 0);
            var endspan = end.Date + ts1;
            var startspan = start.Date + ts;
            TimeSpan amountTime = endspan - startspan;
            //tổng số ngày
            int amountDays = amountTime.Days;

            var import = from idr in db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive
                              && x.InvoiceDetail.Invoice.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                         && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end) && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start))
                         join iv in db.Invoices on idr.ParrentID equals iv.ID into group1

                         from item1 in group1.DefaultIfEmpty()
                         join st in db.Stations on idr.StationID equals st.ID into group2

                         from item2 in group2.DefaultIfEmpty()
                         select new ProfitsStationViewModel
                         {
                             DateTime = (DateTime)idr.Date,
                             Amount = idr.SaleAmount,
                             Revenue = idr.SaleAmount * (idr.ListPrice / (decimal)1.1) - (idr.CostPrice * idr.SaleAmount),
                             HandleInvoice = idr.InvoiceRevenue,
                             CostHandleInvoice = idr.InvoiceRevenue,
                             //Discount = idr.ListPrice - idr.SalePrice,
                             //Commission = idr.InvoiceDetail.SaleAmount,
                             Freight = idr.FreightCharge * idr.SaleAmount,
                             WorkingCaptial = (idr.InvoiceDetail.InvoiceType == "Nợ tiền mặt") ? ((idr.CostPrice * (decimal)1.1 * idr.SaleAmount - idr.CustomerPayment) * (decimal)1.3 + (decimal)0.3 * idr.CustomerPayment) :
                             ((idr.InvoiceDetail.InvoiceType == "Hợp đồng") ? (idr.CostPrice * (decimal)1.1 * idr.SaleAmount * (decimal)1.65)
                             : (idr.CostPrice * (decimal)1.1 * idr.SaleAmount * (decimal)0.3))
                         };
            var invoiceDetail = from id in db.InvoiceDetails.Where(x => x.IsActive && x.Invoice.IsActive
                                && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                                && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end) && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start))

                                select new ProfitsStationViewModel
                                {
                                    DateTime = (DateTime)id.Date,
                                    Discount = id.ListPrice - id.SalePrice,
                                    InvoiceType = id.InvoiceType,
                                    Amount = id.SaleAmount,
                                };

            decimal oilImportMoney = 0;
            decimal electricPhoneMoney = 0;
            decimal customerServiceMoney = 0;
            decimal promotionMoney = 0;
            decimal laborMoney = 0;
            decimal costReturnCompanyMoney = 0;
            var dayOfMonthCompany = 0;
            var dayOfMonthLabor = 0;
            var costManages = db.CostManages.Where(x => x.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : x.StationID == model.StationID)
                    && x.StationID == model.StationID && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end)).ToList();
            //Đơn vị chi phí
            //Dầu nhập
            var oilImport = costManages.Where(x => x.Note == WebResources.OilImportCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (oilImport != null)
            {
                oilImportMoney = oilImport.Money ?? default;
            }
            //Điện, điện thoại
            var electricPhone = costManages.Where(x => x.Note == WebResources.ElectricPhoneCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (electricPhone != null)
            {
                electricPhoneMoney = electricPhone.Money ?? default;
            }
            //Chăm sóc khách hàng
            var customerService = costManages.Where(x => x.Note == WebResources.CustomerServiceCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (customerService != null)
            {
                customerServiceMoney = customerService.Money ?? default;
            }
            //Khuyến mại
            var promotion = costManages.Where(x => x.Note == WebResources.PromotionCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (promotion != null)
            {
                promotionMoney = promotion.Money ?? default;
            }
            //Nhân công theo quy chế
            var labor = costManages.Where(x => x.Note == WebResources.LaborCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (labor != null)
            {
                laborMoney = labor.Money ?? default;
                var dateLabor = (DateTime)labor.Date;
                dayOfMonthLabor = System.DateTime.DaysInMonth(dateLabor.Year, dateLabor.Month);
            }
            //Chi phí nộp lại công ty
            var costReturnCompany = costManages.Where(x => x.Note == WebResources.CostReturnCompanyCode).OrderByDescending(x => x.Date).FirstOrDefault();
            if (costReturnCompany != null)
            {
                costReturnCompanyMoney = costReturnCompany.Money ?? default;
                var dateCompany = (DateTime)costReturnCompany.Date;
                dayOfMonthCompany = System.DateTime.DaysInMonth(dateCompany.Year, dateCompany.Month);
            }
            var countlist = 1;
            List<ProfitsStationViewModel> importlist = new List<ProfitsStationViewModel>();
            List<ProfitsStationViewModel> invoiceCommission = new List<ProfitsStationViewModel>();
            List<ProfitsStationViewModel> invoiceDiscount = new List<ProfitsStationViewModel>();
            var checkStation = false;
            decimal? costHanldeIncrease = 0;
            var station = db.Stations.Where(x => x.ID == model.StationID).FirstOrDefault();
            if (station.StationName == "Phao dầu 1")
            {
                if (import.ToList().Count != 0)
                {
                    var station1 = db.Stations.Where(x => x.IsActive && x.StationName == "Phao dầu 2").Select(x => x.ID).FirstOrDefault();
                    var station2 = db.Stations.Where(x => x.IsActive && x.StationName == "Phao dầu 3").Select(x => x.ID).FirstOrDefault();
                    costHanldeIncrease = db.InvoiceDetailReports.Where(x => x.IsActive && x.InvoiceDetail.IsActive
                             && x.InvoiceDetail.Invoice.IsActive && (x.StationID == station1 || x.StationID == station2)
                             && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(end) && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(start)).Sum(x => x.InvoiceRevenue);
                    checkStation = true;
                }
            }

            foreach (var item in import)
            {
                ProfitsStationViewModel list = new ProfitsStationViewModel
                {
                    DateTime = item.DateTime,
                    Amount = item.Amount,
                    Revenue = item.Revenue,
                    HandleInvoice = item.HandleInvoice.HasValue ? item.HandleInvoice : 0,
                    CostHandleIncrease = checkStation ? costHanldeIncrease : null,
                    CostHandleInvoice = checkStation ? 0 : (item.CostHandleInvoice.HasValue ? (5 * item.CostHandleInvoice) / 100 : 0),
                    Freight = item.Freight,
                    WorkingCaptial = item.WorkingCaptial,
                };
                countlist += 1;
                importlist.Add(list);
            }
            foreach (var item in invoiceDetail)
            {
                if (item.InvoiceType == "Hợp đồng")
                {
                    decimal commissionRate = 0;
                    var commission = db.Commissions.OrderByDescending(x => x.TimeApply).FirstOrDefault(x => x.IsActive && x.TimeApply <= item.DateTime);
                    if (commission != null)
                    {
                        commissionRate = item.Amount * commission.CommissionRate ?? default;
                    }
                    ProfitsStationViewModel list = new ProfitsStationViewModel
                    {
                        Commission = commissionRate,
                    };
                    invoiceCommission.Add(list);
                }
                else
                {
                    ProfitsStationViewModel list = new ProfitsStationViewModel
                    {
                        Discount = item.Discount*item.Amount,
                    };
                    invoiceDiscount.Add(list);
                }
            }

            ProfitsStationViewModel profitItem = new ProfitsStationViewModel
            {
                StationName = station.StationName,
                //=============== Invoice Detail================================
                Discount = invoiceDiscount.Sum(x => x.Discount),
                Commission = invoiceCommission.Sum(x => x.Commission),
                //==================Invoice Detail Report==============================
                Amount = importlist.Sum(x => x.Amount),
                Revenue = importlist.Sum(x => x.Revenue),
                HandleInvoice = importlist.Sum(x => x.HandleInvoice),
                CostHandleIncrease = checkStation ? costHanldeIncrease : null,
                CostHandleInvoice = checkStation ? 0 : importlist.Sum(x => x.CostHandleInvoice),
                Freight = importlist.Sum(x => x.Freight),
                OilImport = importlist.Sum(x => x.Amount) * oilImportMoney,
                ElectricPhone = importlist.Sum(x => x.Amount) * electricPhoneMoney,
                CustomerService = importlist.Sum(x => x.Amount) * customerServiceMoney,
                Promotion = importlist.Sum(x => x.Amount) * promotionMoney,
                WorkingCaptial = (importlist.Sum(x => x.WorkingCaptial) * 12 / 100) / 365 * amountDays,
                Labor = importlist.Sum(x => x.Amount) * ((dayOfMonthLabor != 0) ? (laborMoney / dayOfMonthLabor) : 0) * amountDays,
                CostReturnCompany = importlist.Sum(x => x.Amount) * ((dayOfMonthCompany != 0) ? (costReturnCompanyMoney / dayOfMonthCompany) : 0) * amountDays,
            };
            profitItem.CostStationPayment = (decimal)(profitItem.CostHandleInvoice + profitItem.Discount + profitItem.Commission + profitItem.Freight + profitItem.OilImport
                + profitItem.ElectricPhone + profitItem.CustomerService + profitItem.Promotion + profitItem.WorkingCaptial + profitItem.Labor);
            profitItem.RemainingProfit = (decimal)(profitItem.Revenue + profitItem.HandleInvoice - profitItem.CostStationPayment - profitItem.CostReturnCompany);

            var fileinfo = new FileInfo(string.Format(@"{0}\ProfitsStation.xlsx", HostingEnvironment.MapPath("/Uploads")));
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    productWorksheet.Select();
                    productWorksheet.Cells[1, 1].Value = "BẢNG BÁO CÁO TIỀN MẶT ";
                    productWorksheet.Cells[2, 1].Value = station.StationName.ToUpper();

                    productWorksheet.Cells[3, 1].Value = " TỪ " + model.Time.ToUpper();
                    var productInfo = profitItem;
                    productWorksheet.Cells[5, 3].Value = productInfo.Amount;
                    productWorksheet.Cells[6, 3].Value = productInfo.Revenue;
                    productWorksheet.Cells[7, 3].Value = productInfo.HandleInvoice;
                    productWorksheet.Cells[8, 3].Value = productInfo.CostHandleIncrease;
                    productWorksheet.Cells[10, 3].Value = productInfo.CostHandleInvoice;
                    productWorksheet.Cells[11, 3].Value = productInfo.Discount;
                    productWorksheet.Cells[12, 3].Value = productInfo.Commission;
                    productWorksheet.Cells[13, 3].Value = productInfo.Freight;
                    productWorksheet.Cells[14, 3].Value = productInfo.OilImport;
                    productWorksheet.Cells[15, 3].Value = productInfo.ElectricPhone;
                    productWorksheet.Cells[16, 3].Value = productInfo.CustomerService;
                    productWorksheet.Cells[17, 3].Value = productInfo.Promotion;
                    productWorksheet.Cells[18, 3].Value = productInfo.WorkingCaptial;
                    productWorksheet.Cells[19, 3].Value = productInfo.Labor;
                    productWorksheet.Cells[20, 3].Value = productInfo.CostReturnCompany;
                    if (station.StationName == "Phao dầu 1")
                    {
                        productWorksheet.Row(8).Hidden = false;
                    }
                    else
                    {
                        productWorksheet.Row(8).Hidden = true;
                    }
                    return p.GetAsByteArray();
                }
            }

            return null;
        }
    }
}