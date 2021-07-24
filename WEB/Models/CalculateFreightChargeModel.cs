using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class CalculateFreightChargeModel
    {
        public decimal ListPrice { get; set; }

        public decimal CostPrice { get; set; }

        public int StationId { get; set; }
    }
}