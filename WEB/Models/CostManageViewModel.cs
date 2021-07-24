using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class CostManageViewModel
    {
        public int ID { get; set; }
        public int Count { get; set; }
        public string DataExport { get; set; }
        public DateTime Date { get; set; }

        [RegularExpression(@"^((\b(0[1-9]|[12][0-9]|3[01])\b)\/(\b(0[1-9]|1[012])\b)\/(\d{4}) (\b(0[0-9]|1[0-9]|2[0-3])\b):(\b([0-5][0-9])\b))$",
            ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "TimeNotValid")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "DateRequired")]
        public string DateString { get; set; }
        public string CurrentCode { get; set; }
        public int? StationID { get; set; }
        public string StationName { get; set; }
        public int? Spend { get; set; }
        public string SpendName { get; set; }
        public string SpendCode { get; set; }
        public int? Recipient { get; set; }
        public string RecipientName { get; set; }
        public string RecipientCode { get; set; }
        //[Range(-999999999999, 999999999999, ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "IntMoney1000NotValid")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "MoneyRequired")]
        public string StringMoney { get; set; }
        public decimal? Money { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "NumberArisesRequired")]
        [RegularExpression(@"^([CP])+([0-9]{6})\b$", ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "NumberArisesNotValid")]
        public string NumberArises { get; set; }
        public string Note { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedAt { get; set; }
    }
}