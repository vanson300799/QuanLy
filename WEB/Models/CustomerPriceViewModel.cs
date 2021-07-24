using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class CustomerPriceViewModel
    {
        public int PriceID { get; set; }
        public IEnumerable<int> CustomerID { get; set; }
    }
}