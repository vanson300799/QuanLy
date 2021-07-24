using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class RevenueRecalculationViewModel
    {
        public string Date { get; set; }
        public string InoviceCode { get; set; }
        public string CustomerName { get; set; }
        public string StationName { get; set; }
        public string Note { get; set; }
        public decimal TotalAmount { get; set; }
        public decimal Money { get; set; }
    }
}