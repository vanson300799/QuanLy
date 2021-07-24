using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using WebModels;

namespace WEB.Models
{
    public class InvoiceManageViewModel
    {
        public int ID { get; set; }
        public int Count { get; set; }
        public string DataExport { get; set; }
        public DateTime Date { get; set; }

        [RegularExpression(@"^((\b(0[1-9]|[12][0-9]|3[01])\b)\/(\b(0[1-9]|1[012])\b)\/(\d{4}) (\b(0[0-9]|1[0-9]|2[0-3])\b):(\b([0-5][0-9])\b))$",
            ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "TimeNotValid")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "DateRequired")]
        public string DateString { get; set; }

        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "BillIDRequired")]
        public string InvoiceCode { get; set; }

        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public int? StationID { get; set; }
        public string StationName { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "SupplierRequired")]
        public int? CustomerID { get; set; }
        public string CustomerName { get; set; }
        public string Note { get; set; }
        public decimal? TotalSaleAmount { get; set; }
        public decimal? Money { get; set; }
        public decimal? Tax { get; set; }
        public decimal? TotalMoney { get; set; }
        public bool IsActive { get; set; }
        public bool IsLock { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedAt { get; set; }
        public string CurrentInvoiceCode { get; set; }
        public IEnumerable<InvoiceManageDetail> InvoiceManageDetails { get; set; }
    }
}