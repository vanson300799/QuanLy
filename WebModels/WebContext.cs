using System.Collections.Generic;
using System.Data.Entity;
using System.Linq;

namespace WebModels
{
    public static class DBSetExtension
    {
        public static void RemoveMany<TEntity>(this DbSet<TEntity> thisDbSet, IEnumerable<TEntity> entities) where TEntity : class
        {
            for (int i = entities.Count() - 1; i >= 0; i--)
            {
                if (entities.ElementAt(i) != null)
                    thisDbSet.Remove(entities.ElementAt(i));
            }
        }
    }
    public partial class WebContext : DbContext
    {
        public WebContext()
            : base("DefaultConnection")
        {
        }
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            modelBuilder.Entity<WebContent>().HasKey(e => e.ID);
            modelBuilder.Entity<WebContent>().HasRequired(t => t.ProductInfo).WithRequiredPrincipal(t => t.WebContent).WillCascadeOnDelete(true); ;
            base.OnModelCreating(modelBuilder);
        }
        public DbSet<CustomerPrice> CustomerPrices { get; set; }
        public DbSet<CostManage> CostManages { get; set; }
        public DbSet<DebtManage> DebtManages { get; set; }
        public DbSet<InvoiceManage> InvoiceManages { get; set; }
        public DbSet<InvoiceManageDetail> InvoiceManageDetails { get; set; }
        public DbSet<InvoiceDetail> InvoiceDetails { get; set; }
        public DbSet<InvoiceDetailReport> InvoiceDetailReports { get; set; }
        public DbSet<Invoice> Invoices { get; set; }
        public DbSet<FreightCharge> FreightCharges { get; set; }
        public DbSet<DealDetail> DealDetails { get; set; }        
        public DbSet<Price> Prices { get; set; }
        public DbSet<ImportOrder> ImportOrders { get; set; }
        public DbSet<ImportOrderDetail> ImportOrderDetails { get; set; }
        public DbSet<Commission> Commissions { get; set; }
        public DbSet<Product> Products { get; set; }
        public DbSet<ListedPrice> ListedPrices { get; set; }
        public DbSet<Supplier> Suppliers { get; set; }
        public DbSet<Customer> Customers { get; set; }
        public DbSet<Station> Stations { get; set; }
        public DbSet<LogSystem> LogSystems { get; set; }
        public DbSet<NoteBookKey> NoteBookKeys { get; set; }
        public DbSet<UserProfile> UserProfiles { get; set; }
        public DbSet<WebRole> WebRoles { get; set; }
        public DbSet<UserInRole> UserInRoles { get; set; }
        public DbSet<WebContentUpload> WebContentUploads { get; set; }
        public DbSet<AccessWebModule> AccessWebModules { get; set; }
        public DbSet<ContentType> ContentTypes { get; set; }
        public DbSet<WebContact> WebContacts { get; set; }
        public DbSet<WebContent> WebContents { get; set; }
        public DbSet<FaceInfo> FaceInfos { get; set; }
        public DbSet<ContentRelated> ContentRelateds { get; set; }
        public DbSet<ProductInfo> ProductInfos { get; set; }
        public DbSet<WebRedirect> WebRedirects { get; set; }
        public DbSet<WebModule> WebModules { get; set; }
        public virtual DbSet<Navigation> Navigations { get; set; }
        public virtual DbSet<ModuleNavigation> ModuleNavigations { get; set; }
        public DbSet<WebSimpleContent> WebSimpleContents { get; set; }
        public DbSet<WebSlide> WebSlides { get; set; }
        public DbSet<WebLink> WebLinks { get; set; }
        public DbSet<Province> Provinces { get; set; }
        public DbSet<Country> Countries { get; set; }
        public DbSet<AdminSite> AdminSites { get; set; }
        public DbSet<AccessAdminSite> AccessAdminSites { get; set; }
        public DbSet<AccessLog> AccessLogs { get; set; }
        public DbSet<WebConfig> WebConfigs { get; set; }
        public DbSet<Language> Languages { get; set; }
        public DbSet<WebCategory> WebCategories { get; set; }
        public DbSet<WebContentCategory> WebContentCategories { get; set; }
        public DbSet<ContentImage> ContentImages { get; set; }
        public DbSet<SupportOnline> SupportOnlines { get; set; }
        public DbSet<Destination> Destinations { get; set; }
        public DbSet<UploadFile> UploadFiles { get; set; }
        public DbSet<AccessWebModuleRole> AccessWebModuleRoles { get; set; }
        public DbSet<AccessAdminSiteRole> AccessAdminSitesRoles { get; set; }
    }

    public enum CTypeCategories
    {
        Common = 0,
        Product = 1,
        News = 2
    }

    public enum AccessLogActions
    {
        View,
        Add,
        Edit,
        Delete,
        Login
    }
    public enum AccessKeys
    {
        Home,
        Role,
        User,
        AdminSite,
        ContentType,
        AccessLog,
        WebConfig,
        WebModule,
        Navigation,
        WebContent,
        WebSimpleContent,
        Country,
        Province,
        Support,
        WebLink,
        WebSlide,
        AdvPosition,
        Advertisement,
        Helps,
        WebCategory,
        ProductCategory,
        SubscribeNotice
    }

    public enum Permissions
    {
        View,
        Add,
        Edit,
        Delete
    }
    public enum DataModules
    {
        WebContent,
        WebSimpleContent
    }
    public enum Status { Private = -1, Internal = 0, Public = 1 }

    public enum StatusUser { TaoMoi = -2, GuiDi = -3, TraLai = -4 }

    public enum LoaiLienHe { YKienCuaBan = 1, DatMua = 2, LienHeToaSon = 3, ThuMoiNghienCuu = 4 }
    public enum LoaiDonHang { DienTu = 1, Giay = 2 }

}
