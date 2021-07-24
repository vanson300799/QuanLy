using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WebModels;

namespace WEB.Models
{
    public class ProfitsStationViewModel
    {
        public string Time { get; set; }
        public DateTime DateTime { get; set; }
        public string StartTime { get; set; }
        public string EndTime { get; set; }
        //Sản lượng
        public decimal Amount { get; set; }
        //Doanh thu
        public decimal Revenue { get; set; }
        //Xử lý hóa đơn
        public decimal? HandleInvoice { get; set; }
        //Chi phí xử lý tăng thêm
        public decimal? CostHandleIncrease { get; set; }
        //Chi phí cửa hàng chi trả
        public decimal CostStationPayment { get; set; }
        //Chi phí xử lý hóa đơn
        public decimal? CostHandleInvoice { get; set; }
        //Chiết khấu
        public decimal Discount { get; set; }
        //Hoa hồng
        public decimal Commission { get; set; }
        //Vận chuyển
        public decimal Freight { get; set; }
        //Dầu nhập
        public decimal OilImport { get; set; }
        //Điện, điện thoại
        public decimal ElectricPhone { get; set; }
        //Chăm sóc khách hàng
        public decimal CustomerService { get; set; }
        //Khuyến mại
        public decimal Promotion { get; set; }
        //CPTC vốn lưu động
        public decimal WorkingCaptial { get; set; }
        //Nhân công theo quy chế
        public decimal Labor { get; set; }
        //Chi phí nộp lại công ty
        public decimal CostReturnCompany { get; set; }
        //Lợi nhuận còn lại
        public decimal RemainingProfit { get; set; }

        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public int? StationID { get; set; }
        public string StationName { get; set; }
        public string InvoiceType { get; set; }
    }
}