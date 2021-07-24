using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using WebModels;

namespace WEB.Models
{
    public class LogSystemViewModel
    {
        public DateTime CreatedAt { get; set; }
        public int CreatedBy { get; set; }
        public int ID { get; set; }
        public string Information { get; set; }
        public string ActiveType { get; set; }
        public string FunctionName { get; set; }
        public string DataTable { get; set; }
        public string UserName { get; set; }
    }
}