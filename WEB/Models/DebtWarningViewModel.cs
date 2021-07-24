using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebModels;

namespace WEB.Models
{
    public class DebtWarningViewModel
    {
        public int Count { get; set; }
        public string TimeString { get; set; }
        public DateTime DateTime { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string CustomerName { get; set; }
        public string Vehicle { get; set; }
        public decimal Debt { get; set; }
        public int DebtDate { get; set; }
        public string Note { get; set; }        
        public int? StationID { get; set; }
        public int CustomerID { get; set; }
        public decimal CustomerMoney { get; set; }
        public string StationName { get; set; }
    }
}