using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using WebModels;

namespace WEB.Models
{
    public class InvoiceIndexViewModel
    {
        public int ID { get; set; }
        public DateTime Date { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "BillIDRequired")]
        [RegularExpression(@"^([DN])+([0-9]{6})\b$", ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "InvoiceCodeNotValid")]
        public string InvoiceCode { get; set; }

        [RegularExpression(@"^((\b(0[1-9]|[12][0-9]|3[01])\b)\/(\b(0[1-9]|1[012])\b)\/(\d{4}) (\b(0[0-9]|1[0-9]|2[0-3])\b):(\b([0-5][0-9])\b))$",
            ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "TimeNotValid")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "DateRequired")]
        public string DateString { get; set; }
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public string Vehicle { get; set; }

        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public int? StationID { get; set; }
        public string StationName { get; set; }
        public string StationCode { get; set; }

        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "CustomerRequired")]
        public int? CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string CustomerCode { get; set; }
        public string Note { get; set; }
        public decimal? TotalQuantity { get; set; }
        public decimal? TotalFreightCharge { get; set; }
        public decimal? TotalMoney { get; set; }
        public decimal? TotalDiscount { get; set; }
        public decimal? CustomerPayment { get; set; }
        public decimal? TotalRevenue { get; set; }
        public bool IsLock { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime? ModifiedAt { get; set; }
        public IEnumerable<InvoiceDetail> InvoiceDetails { get; set; }
    }
}