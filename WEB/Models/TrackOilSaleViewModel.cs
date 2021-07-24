using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class TrackOilSaleViewModel
    {
        public int Count { get; set; }
        public int Date
        {
            get
            {
                return DateTime.Day;
            }
        }
        public DateTime DateTime { get; set; }
        public string Customer { get; set; }
        public string Vehicle { get; set; }
        public decimal SaleNumber { get; set; }
        public decimal UnitPrice { get; set; }
        public decimal? PaidPrice { get; set; }
        public decimal? CompanyDebtPrice { get; set; }
        public decimal? BookDebtPrice { get; set; }
        public string ProductDisplayName { get; set; }
        public string Time { get; set; }
        public string StationDisplayName { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "ProductRequired")]
        public int? ProductID { get; set; }
        public int? StationID { get; set; }
        public string StationName { get; set; }
    }
}