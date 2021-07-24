using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class ImportOrderDetailViewModel
    {
        public int ID { get; set; }
        public int ParrentID { get; set; }
        public DateTime Date { get; set; }
        public int StationID { get; set; }
        public string StationName { get; set; }
        public string StationCode { get; set; }
        public int ProductID { get; set; }
        public string ProductCode { get; set; }
        public string ProductName { get; set; }
        public int SupplierID { get; set; }
        public string SupplierName { get; set; }
        public decimal InputNumber { get; set; }
        public decimal InputPrice { get; set; }
        public decimal Money { get; set; }
        public bool IsActive { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public int ModifiedBy { get; set; }
        public DateTime? ModifiedAt { get; set; }
        public string ProductDisplayName
        {
            get
            {
                return string.Format("{0}:{1}", ProductCode, ProductName);
            }
        }
        public string StationDisplayName
        {
            get
            {
                return string.Format("{0}:{1}", StationCode, StationName);
            }
        }
    }
}