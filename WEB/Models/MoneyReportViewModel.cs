using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebModels;

namespace WEB.Models
{
    public class MoneyReportViewModel
    {
        public int Count { get; set; }
        public string Time { get; set; }
        public DateTime DateTime { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string CustomerName { get; set; }
        public string Vehicle { get; set; }
        public decimal Amount { get; set; }
        public decimal Money { get; set; }
        public decimal Debt { get; set; }
        public decimal CustomerPayment { get; set; }
        public string Note { get; set; }

        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public int? StationID { get; set; }
        public string StationName { get; set; }
    }
}