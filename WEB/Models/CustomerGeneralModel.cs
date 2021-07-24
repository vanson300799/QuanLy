using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class CustomerGeneralModel
    {
        public DateTime? DateTime { get; set; }
        public string Date { get; set; }
        public string CustomerName { get; set; }
        public int CustomerID { get; set; }
        public int StationID { get; set; }
        public List<ListProductReportCustomer> listProductReportCustomers { get; set; }
    }
}