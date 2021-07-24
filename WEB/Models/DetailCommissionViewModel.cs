using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebModels;

namespace WEB.Models
{
    public class DetailCommissionViewModel
    {
        public int Count { get; set; }
        public string Time { get; set; }
        public DateTime DateTime { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string Note { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public int? StationID { get; set; }
        public int CustomerID { get; set; }
        public string StationName { get; set; }
        public string CustomerCode { get; set; }
        public decimal SaleAmount { get; set; }
        public decimal Discount { get; set; }
        public decimal Money { get; set; }
    }
}