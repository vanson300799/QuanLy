using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class DetailImportViewModel
    {
        public string Time { get; set; }
        public string DateTime { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string InvoiceCode { get; set; }
        public int? ProductID { get; set; }
        public int?  StationID { get; set; }
        public string StationName { get; set; }
        public string StationDisplayName { get; set; }
        public int Count { get; set; }
        public string ProductName { get; set; }
        public string ProductDisplayName { get; set; }
        public string ProductCode { get; set; }
        public decimal InputNumber { get; set; }
        public decimal CostPrice { get; set; }
        public decimal ListPrice { get; set; }
        public decimal InputPrice { get; set; }
    }
}