using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class ExcelImportViewModel
    {
        public string Time { get; set ; }
        public string StationName { get; set ; }
        public int? ProductID { get; set; }
        public string ProductName { get; set; }
        public int StationID { get; set; }
        public string DataExport { get; set; }
        public int Count { get; set; }
        public decimal CostPrice { get; set; }
        public decimal Weigh { get; set; }
    }
}