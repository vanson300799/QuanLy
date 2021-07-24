using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class DetailImportReportModel
    {
        public int ProductID { get; set; }
        public int StationID { get; set; }
        public string StationName { get; set; }
        public int Count { get; set; }
        public string ProductName { get; set; }
        public string ProductDisplayName { get; set; }
        public string ProductCode { get; set; }
        public string InvoiceCode { get; set; }
        public string Time { get; set; }
        public DateTime? DateTime { get; set; }
        public decimal InputNumber { get; set; }
        public decimal InputPrice { get; set; }
        public decimal CostPrice { get; set; }
        public decimal ListedPrice { get; set; }
    }
}