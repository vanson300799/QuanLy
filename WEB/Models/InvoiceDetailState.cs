using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class InvoiceDetailState
    {
        public InvoiceDetail InvoiceDetail { get; set; }

        public decimal QuantityLeft { get; set; }
    }
}