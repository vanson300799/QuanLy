using System;

namespace WEB.Models
{
    public class CustomerViewModel
    {
        public int ID { get; set; }
        public string CustomerCode { get; set; }
        public string CustomerName { get; set; }
        public string TaxCode { get; set; }
        public string CustomerAddress { get; set; }
        public string PhoneNumber { get; set; }
        public string Information { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime? ModifiedAt { get; set; }
    }
}