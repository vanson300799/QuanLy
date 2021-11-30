using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.DataAnnotations.Schema;
using System.Data.Entity;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Text;
using WebMatrix.WebData;

namespace WebModels
{
    [Table("NoteBookKey")]
    public partial class NoteBookKey
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(AccountResources), Name = "DateTimeKey")]
        public DateTime? DateTimeKey { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "IsActive")]
        public bool IsActive { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime? CreatedAt { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int ModifiedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }
    }

    [Table("LogSystem")]
    public partial class LogSystem
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "UserId")]
        public int UserID { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ActiveType")]
        public string ActiveType { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "FunctionName")]
        public string FunctionName { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "DataTable")]
        public string DataTable { get; set; }
        [DataType(DataType.DateTime)]
        [DisplayFormat(DataFormatString = "{0:MM/dd/yyyy HH:mm}", ApplyFormatInEditMode = true)]
        [Display(ResourceType = typeof(WebResources), Name = "DateTime")]
        public DateTime? DateTime { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "Information")]
        public string Information { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "IsActive")]
        public bool IsActive { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime? CreatedAt { get; set; }
    }

    [Table("Rent")]
    public partial class Rent
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }

        public string ProductCode { get; set; }
        public string ProductName { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "TaxCode")]
        public string CompanyRent { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CustomerAddress")]
        public int? TimeRent { get; set; }
        public int? Price { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "IsActive")]
        public bool IsActive { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int? CreatedBy { get; set; }

        public DateTime? CreatedAt { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int? ModifiedBy { get; set; }
        public int? Number { get; set; }

        public DateTime? ModifiedAt { get; set; }
        public int? ProductID { get; set; }
        public int? Status { get; set; }
        public DateTime? DeliveryTime { get; set; }
        [ForeignKey("ProductID")]
        public virtual Product Products { get; set; }

        public int? Total { get; set; }
    }

    [Table("Station")]
    public partial class Station
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ShopCode")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredShopCode")]
        public string StationCode { get; set; }
        [NotMapped]
        public string CurrentCode { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ShoprName")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredShopName")]
        public string StationName { get; set; }
        public string UserChange { get; set; }


        public string PositionOld { get; set; }
        
        public string PositionNew { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "IsActive")]
        public bool IsActive { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime? CreatedAt { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int ModifiedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }
    }

    [Table("Supplier")]
    public partial class Supplier
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "SupplierID")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredSupplierID")]
        public string SupplierCode { get; set; }
        [NotMapped]
        public string CurrentCode { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "SupplierName")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredSupplierName")]
        public string SupplierName { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "TaxCode")]
        public string TaxCode { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "SupplierAddress")]
        public string SupplierAddress { get; set; }
       
        [Display(ResourceType = typeof(WebResources), Name = "Phone")]
        public string PhoneNumber { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "Information")]
        public string Information { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "IsActive")]
        public bool IsActive { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime? CreatedAt { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int ModifiedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }
    }

    [Table("Product")]
    public partial class Product
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CommodityID")]
        public string ProductCode { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CommodityName")]
        public string ProductName { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "Information")]
        public string Information { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "IsActive")]
        public bool IsActive { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime? CreatedAt { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int ModifiedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }
        public string Position { set; get; }
        public string Image { set; get; }
        public int? Price { get; set; }
        public int? Number { get; set; }


    }
    [Table("ListedPrice")]
    public partial class ListedPrice
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "TimeApply")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredTimeApply")]
        public DateTime TimeApply { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "PriceListed")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredPriceListed")]
        [Range(0, 99999999.99, ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredPriceListed")]
        [RegularExpression(@"^(0|-?\d{0,8}(\.\d{0,2})?)$", ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "ErrorPrice")]
        public decimal PriceListed { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CommodityID")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "RequiredCommodityID")]
        public int ProductID { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "Information")]
        public string Information { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "IsActive")]
        public bool IsActive { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime CreatedAt { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int? ModifiedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }

    }

    [Table("InvoiceDetail")]
    public partial class InvoiceDetail
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "DateTime")]
        public DateTime? Date { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ParrentID { get; set; }
        public int ProductID { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ShopID")]
        public int StationID { get; set; }
        public int CustomerID { get; set; }
        public decimal SaleAmount { get; set; }
        public decimal InvoiceRevenue { get; set; }
        public decimal CostPrice { get; set; }
        public decimal SalePrice { get; set; }
        public decimal ListPrice { get; set; }
        public decimal FreightCharge { get; set; }
        public decimal SupplierDiscount { get; set; }
        public string InvoiceType { get; set; }
        public decimal CustomerPayment { get; set; }
        public decimal Money { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "IsActive")]
        public bool IsActive { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime CreatedAt { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public Nullable<int> ModifiedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }

        [ForeignKey("ParrentID")]
        public virtual Invoice Invoice { get; set; }
    }

    [Table("InvoiceDetailReport")]
    public partial class InvoiceDetailReport
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "DateTime")]
        public DateTime? Date { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ParrentID { get; set; }
        public int InvoiceDetailId { get; set; }

        [ForeignKey("InvoiceDetailId")]
        public virtual InvoiceDetail InvoiceDetail { get; set; }
        public int ProductID { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ShopID")]
        public int StationID { get; set; }
        public int CustomerID { get; set; }
        public decimal SaleAmount { get; set; }
        public decimal InvoiceRevenue { get; set; }
        public decimal CostPrice { get; set; }
        public decimal SalePrice { get; set; }
        public decimal ListPrice { get; set; }
        public decimal FreightCharge { get; set; }
        public decimal SupplierDiscount { get; set; }
        public string InvoiceType { get; set; }
        public decimal CustomerPayment { get; set; }
        public decimal Money { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "IsActive")]
        public bool IsActive { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime CreatedAt { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public Nullable<int> ModifiedBy { get; set; }

        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }

        [NotMapped]
        public decimal SaleAmountLeft { get; set; }

        [NotMapped]
        public bool IsProcessed { get; set; }
    }

    [Table("Invoice")]
    public partial class Invoice
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "DateTime")]
        public DateTime Date { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ShopID")]
        public int? StationID { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "CustomerRequired")]
        public int CustomerID { get; set; }
        public string Note { get; set; }
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "BillIDRequired")]
        public string InvoiceCode { get; set; }
        public string Vehicle { get; set; }
        public decimal? TotalQuantity { get; set; }
        public decimal? TotalFreightCharge { get; set; }
        public decimal? TotalMoney { get; set; }
        public decimal? TotalDiscount { get; set; }
        public decimal? CustomerPayment { get; set; }
        public decimal? TotalRevenue { get; set; }
        public bool IsLock { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "IsActive")]
        public bool IsActive { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime CreatedAt { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public Nullable<int> ModifiedBy { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }
    }

    [Table("InvoiceManage")]
    public partial class InvoiceManage
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "DateTime")]
        public DateTime Date { get; set; }
        public string InvoiceCode { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "ShopID")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "StationRequired")]
        public int StationID { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CustomerID")]
        [Required(ErrorMessageResourceType = typeof(WebResources), ErrorMessageResourceName = "SupplierRequired")]
        public int CustomerID { get; set; }
        public string Note { get; set; }
        public decimal TotalSaleAmount { get; set; }
        public decimal Money { get; set; }
        public decimal Tax { get; set; }
        public decimal TotalMoney { get; set; }
        public bool IsLock { get; set; }
        public bool IsActive { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime CreatedAt { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int? ModifiedBy { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }
    }

    [Table("InvoiceManageDetail")]
    public partial class InvoiceManageDetail
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        public int ParentID { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "DateTime")]
        public DateTime Date { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ShopID")]
        public int? StationID { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CustomerID")]
        public int CustomerID { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CommodityID")]
        public int ProductID { get; set; }
        public decimal SaleAmount { get; set; }
        public decimal Money { get; set; }
        public decimal Price { get; set; }
        public bool IsActive { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime CreatedAt { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int? ModifiedBy { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }
        [ForeignKey("ParentID")]
        public virtual InvoiceManage InvoiceManages { get; set; }
    }
    [Table("DebtManage")]
    public partial class DebtManage
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        public DateTime Date { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ShopID")]
        public int? StationID { get; set; }

        [Display(ResourceType = typeof(WebResources), Name = "CustomerID")]
        public int? CustomerID { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CommodityID")]
        public decimal? Money { get; set; }
        public string DealCode { get; set; }
        public string Note { get; set; }
        public bool IsActive { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime CreatedAt { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int? ModifiedBy { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }
    }

    [Table("CostManage")]
    public partial class CostManage
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        public DateTime Date { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ShopID")]
        public int? StationID { get; set; }
        public int? Spend { get; set; }
        public int? Recipient { get; set; }
        public decimal? Money { get; set; }
        public string NumberArises { get; set; }
        public string Note { get; set; }
        public bool IsActive { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "CreatedBy")]
        public int CreatedBy { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "CreatedAt")]
        public DateTime CreatedAt { get; set; }
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedBy")]
        public int? ModifiedBy { get; set; }
        [DataType(DataType.DateTime)]
        [Display(ResourceType = typeof(WebResources), Name = "ModifiedDate")]
        public DateTime? ModifiedAt { get; set; }
    }
    [Table("CustomerPrice")]
    public partial class CustomerPrice
    {
        [Key]
        [DatabaseGeneratedAttribute(DatabaseGeneratedOption.Identity)]
        [Display(ResourceType = typeof(WebResources), Name = "ID")]
        public int ID { get; set; }
        public int PriceID { get; set; }
        public int CustomerID { get; set; }
    }
}
