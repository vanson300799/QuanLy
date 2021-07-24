using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class ProductViewModel
    {

        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CommodityID")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredCommodityID")]
        public string ProductCode { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CommodityName")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredCommodityName")]
        public string ProductName { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "Tax")]
        public string Position { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "Information")]
        public string Information { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int ModifiedBy { get; set; }
        public Nullable<DateTime> ModifiedAt { get; set; }
        public string Image { get; set; }
    }
}