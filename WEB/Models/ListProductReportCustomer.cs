﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class ListProductReportCustomer
    {
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public string ProductCode { get; set; }
        public decimal ProductSaleAmount { get; set; }
        public decimal ProductMoney { get; set; }
    }
}