using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class SupplierViewModel
    {
        public int ID { get; set; }
        public string SupplierCode { get; set; }
        public string SupplierName { get; set; }
        public string TaxCode { get; set; }
        public string SupplierAddress { get; set; }
        public string PhoneNumber { get; set; }
        public string Information { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int ModifiedBy { get; set; }
        public Nullable<DateTime> ModifiedAt { get; set; }
    }
}