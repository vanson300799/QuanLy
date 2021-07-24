using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WEB.Models
{
    public class InvoiceDetailViewModel
    {
        public int ID { get; set; }
        public DateTime? Date { get; set; }
        public int ParrentID { get; set; }
        public int ProductID { get; set; }
        public string ProductName { get; set; }
        public string ProductCode { get; set; }
        public decimal SaleAmount { get; set; }
        public decimal InvoiceRevenue { get; set; }
        public decimal Money { get; set; }
        public decimal CostPrice { get; set; }
        public decimal SalePrice { get; set; }
        public decimal ListPrice { get; set; }
        public decimal FreightCharge { get; set; }
        public decimal SupplierDiscount { get; set; }
        public string InvoiceType { get; set; }
        public decimal CustomerPayment { get; set; }
        public bool IsActive { get; set; }
        public string ProductDisplayName
        {
            get
            {
                return string.Format("{0} : {1}", ProductCode, ProductName);
            }
        }
        public string InvoiceDisplayName
        {
            get
            {
                return string.Format("{0}", InvoiceType);
            }
        }

        public string InvoiceCode { get; set; }
        public int CreatedBy { get; set; }
        public DateTime CreatedAt { get; set; }
        public Nullable<int> ModifiedBy { get; set; }
        public DateTime? ModifiedAt { get; set; }
    }
}