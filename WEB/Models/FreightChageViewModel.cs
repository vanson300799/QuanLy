using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using WebModels;

namespace WEB.Models
{
    public class FreightChageViewModel
    {

        public int ID { get; set; }
        public DateTime TimeApply { get; set; }

        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredTimeApply")]
        [RegularExpression(@"^((\b(0[1-9]|[12][0-9]|3[01])\b)\/(\b(0[1-9]|1[012])\b)\/(\d{4}) (\b(0[0-9]|1[0-9]|2[0-3])\b):(\b([0-5][0-9])\b))$",
            ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "TimeNotValid")]
        public string StringTimeApply { get; set; }

        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public Nullable<int> StationID { get; set; }

        public string Information { get; set; }

        public bool IsLock { get; set; }

        public bool IsActive { get; set; }

        public int CreatedBy { get; set; }

        public DateTime? CreatedAt { get; set; }

        public int ModifiedBy { get; set; }

        public DateTime? ModifiedAt { get; set; }
        public string StationName { get; set; }

        public string StationCode { get; set; }

        public IEnumerable<DealDetail> DealDetails { get; set; }

    }
}