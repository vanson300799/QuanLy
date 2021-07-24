using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class ImportViewModel
    {
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        public string Time { get; set; }
        public int? ProductID { get; set; }
        public int? StationID { get; set; }
    }
}