using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using WebModels;

namespace WEB.Models
{
    public class InvoiceManageDetailViewModel
    {
        public int ID { get; set; }
        public int ParentID { get; set; }
        public DateTime Date { get; set; }
        public string DateString { get; set; } 
        public int? StationID { get; set; }
        public string StationName { get; set; }
        public string StationCode { get; set; }
        public int? ProductID { get; set; }
        public string ProductName { get; set; }
        public string ProductCode { get; set; }
        public string ProductDisplayName
        {
            get
            {
                return string.Format("{0} : {1}", ProductCode, ProductName);
            }
        }
        public int? CustomerID { get; set; }
        public string CustomerName { get; set; }
        public decimal? SaleAmount { get; set; }
        public decimal? Money { get; set; }
        public decimal? Price { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int? ModifiedBy { get; set; }
        public DateTime? ModifiedAt { get; set; }
    }
}