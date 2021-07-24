using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebModels;

namespace WEB.Models
{
    public class RevenueSalesViewModel
    {
        public int Count { get; set; }
        public string Time { get; set; }
        public DateTime DateTime { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string InvoiceCode { get; set; }
        public string Note { get; set; }
        public int? ProductID { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public int? StationID { get; set; }
        public int CustomerID { get; set; }
        public string StationName { get; set; }
        public string ProductName { get; set; }
        public string CustomerCode { get; set; }
        public string ProductDisplayName { get; set; }
        public string ProductCode { get; set; }
        public string Vehicle { get; set; }
        public decimal SalePrice { get; set; }
        public decimal CostPrice { get; set; }
        public decimal CostPriceCal { get; set; }
        public decimal Revenue { get; set; }
        public decimal RevenueSale { get; set; }
        public decimal? RevenueInvoice { get; set; }
        public decimal SaleAmount { get; set; }
    }
}