using System;
using System.ComponentModel.DataAnnotations;
using WebModels;

namespace WEB.Models
{
    public class StationViewModel
    {
        [Display(ResourceType = typeof(WebResources), Name = "ShoprName")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredShopName")]
        public int ID { get; set; }
        public string StationCode { get; set; }
        public string StationName { get; set; }
        public string PositionOld { get; set; }
        public string PositionNew { get; set; }
        public string UserChange { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime? ModifiedAt { get; set; }
    }
}