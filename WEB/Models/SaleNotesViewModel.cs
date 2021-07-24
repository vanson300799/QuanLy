using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class SaleNotesViewModel: TrackOilSaleViewModel
    {
        public Decimal? ListedPrice { get; set; }
        public Decimal? ListedPriceBeforeTax { get; set; }
        public Decimal? CostPriceBeforeTax { get; set; }
        public Decimal? CarrierTransfer { get; set; }
        public Decimal? Freight { get; set; }
        public Decimal? Discount { get; set; }

        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public new int? StationID { get; set; }

        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public decimal SupplierDiscount { get; set; }
    }
}