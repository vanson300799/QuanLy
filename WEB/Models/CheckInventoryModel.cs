using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class CheckInventoryModel
    {
        public List<decimal>  SaleAmount { get; set; }
        public int StationID { get; set; }
        public List<int> ListProductID { get; set; }
    }
}