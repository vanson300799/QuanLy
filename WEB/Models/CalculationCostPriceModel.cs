using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class CalculationCostPriceModel
    {
        public int StationID { get; set; }
        public int ProductID { get; set; }
        public decimal Amount { get; set; }
    }
}