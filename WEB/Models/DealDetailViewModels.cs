using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class DealDetailViewModels
    {
        public int ID { get; set; }
        public int ParentID { get; set; }

        public DateTime? Date { get; set; }
        public int StationID { get; set; }
        public string Description { get; set; }
        public decimal DiscountAmount { get; set; }
        public decimal FreightCharge { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedAt { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime? ModifiedAt { get; set; }
    }
}