using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace WEB.Models
{
    public class CostIncurredViewModel
    {
        public int Count { get; set; }
        public string Time { get; set; }
        public DateTime DateTime { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string Note { get; set; }
        public string SpendName { get; set; }
        public string RecipientName { get; set; }
        public int? StationID { get; set; }
        public string StationName { get; set; }
        public decimal Money { get; set; }
    }
}