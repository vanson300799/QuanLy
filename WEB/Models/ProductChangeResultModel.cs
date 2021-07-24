using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class ProductChangeResultModel
    {
        public decimal? QuantityLeft { get; set; }
        public decimal? totalAvailableQuantity { get; set; }
        public decimal? Price { get; set; }
        public decimal? ListedPrice { get; set; }
        public decimal? CostPrice { get; set; }
        public decimal? FreightCharges { get; set; }
        public int StationID { get; set; }
        public int? ProductID { get; set; }
        public string ProductDisplayName { get; set; }
        public decimal Amount { get; set; }
        public string Time { get; set; }
    }
}