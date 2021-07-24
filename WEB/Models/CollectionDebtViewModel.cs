using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WEB.Models
{
    public class CollectionDebtViewModel
    {
        public int Count { get; set; }
        public string Time { get; set; }
        public DateTime DateTime { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string InvoiceCode { get; set; }
        public string Note { get; set; }
        public int? StationID { get; set; }
        public string StationName { get; set; }
        public int? CustomerID { get; set; }
        public string CustomerCode { get; set; }
        public string CustomerName { get; set; }
        public decimal Money { get; set; }
        public decimal DebtPriceGrow { get; set; }
        public decimal HavePriceGrow { get; set; }
        public decimal HavePriceBegin { get; set; }
        public decimal DebtPriceBegin { get; set; }
        public decimal HavePriceTerm { get; set; }
        public decimal DebtPriceTerm { get; set; }
    }
}