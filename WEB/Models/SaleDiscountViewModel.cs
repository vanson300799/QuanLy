using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class SaleDiscountViewModel
    {
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "ProductRequired")]
        public int? ProductID { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public int? StationID { get; set; }
        public string StationName { get; set; }
        public int Count { get; set; }
        public string ProductName { get; set; }
        public string Note { get; set; }
        public string ProductDisplayName { get; set; }
        public string ProductCode { get; set; }
        public string Time { get; set; }
        public DateTime? DateTime { get; set; }
        public decimal SaleAmount { get; set; }
        public decimal SalePrice { get; set; }
        public decimal CostPrice { get; set; }
        public decimal ListedPrice { get; set; }
        public decimal Money { get; set; }
        public decimal Discount { get; set; }
        public int CustomerID { get; set; }
        public string CustomerCode { get; set; }
    }
}