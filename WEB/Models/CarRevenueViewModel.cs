using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class CarRevenueViewModel
    {
        public string Time { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public int? StationID { get; set; }
        public int InvoiceID { get; set; }
        public string StationName { get; set; }
        public string StationDisplayName { get; set; }
        public int Count { get; set; }
        public string Vehicle { get; set; }
        public decimal Amount { get; set; }
        public decimal Revenue { get; set; }
        public decimal Cost { get; set; }
    }
}