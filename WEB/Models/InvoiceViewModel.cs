using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using WebModels;

namespace WEB.Models
{
    public class InvoiceViewModel
    {
        public int ID { get; set; }
        public DateTime Date { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "BillIDRequired")]
        //[RegularExpression(@"^()+([0-9]{7})\b$", ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "InvoiceCodeNotValid")]
        public string InvoiceCode { get; set; }
        public string CurrentInvoiceCode { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "DateRequired")]

        [RegularExpression(@"^((\b(0[1-9]|[12][0-9]|3[01])\b)\/(\b(0[1-9]|1[012])\b)\/(\d{4}) (\b(0[0-9]|1[0-9]|2[0-3])\b):(\b([0-5][0-9])\b))$",
            ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "TimeNotValid")]
        public string DateString { get; set; }
        public int ProductID { get; set; }
        public string ProductName { get; set; }

        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public int? StationID { get; set; }
        public string StationName { get; set; }
        public string StationCode { get; set; }
        public int? CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string CustomerCode { get; set; }
        public string Note { get; set; }
        public string TotalQuantity { get; set; }
        public string TotalFreightCharge { get; set; }
        public string TotalMoney { get; set; }
        public string TotalDiscount { get; set; }
        public string CustomerPayment { get; set; }
        public string TotalRevenue { get; set; }
        public string Vehicle { get; set; }
        public bool IsLock { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime? ModifiedAt { get; set; }
        public IEnumerable<InvoiceDetail> InvoiceDetails { get; set; }
    }
}