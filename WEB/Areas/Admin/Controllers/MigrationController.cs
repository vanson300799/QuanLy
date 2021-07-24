using Common;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Linq;
using System.Web.Mvc;
using WEB.WebHelpers;
using WebModels;
namespace WEB.Areas.Admin.Controllers
{
    public class MigrationController : Controller
    {
        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }

        // GET: Admin/MigrateInvoice
        public ActionResult MigrateInvoice()
        {
            try
            {
                var currentUser = UserInfoHelper.GetUserData();
                if (currentUser == null)
                {
                    return null;
                }

                var allInvoiceDetails = db.InvoiceDetails.Where(x => x.IsActive);

                foreach (var item in allInvoiceDetails)
                {
                    var helper = new RecalculateHelper();
                    var costPriceResult = helper.GetMigrationCostPrice(db, item.ProductID, item.StationID, item);

                    db.InvoiceDetailReports.RemoveMany(db.InvoiceDetailReports.Where(x => x.InvoiceDetailId == item.ID));

                    foreach (var costPriceItem in costPriceResult)
                    {
                        var invoiceDetailReport = new InvoiceDetailReport()
                        {
                            ParrentID = item.ParrentID,
                            ProductID = item.ProductID,
                            SalePrice = item.SalePrice,
                            ListPrice = item.ListPrice,
                            FreightCharge = item.FreightCharge,
                            CustomerID = item.CustomerID,
                            SupplierDiscount = item.SupplierDiscount,
                            CustomerPayment = item.CustomerPayment,
                            InvoiceRevenue = item.InvoiceRevenue,
                            InvoiceType = item.InvoiceType,
                            Money = item.SaleAmount * item.SalePrice,
                            StationID = item.StationID,
                            ModifiedAt = DateTime.Now,
                            ModifiedBy = currentUser.UserId,
                            InvoiceDetailId = item.ID,
                            CostPrice = costPriceItem.Price,
                            SaleAmount = costPriceItem.QuantityTaken,
                            CreatedAt = DateTime.Now,
                            CreatedBy = currentUser.UserId,
                            Date = item.Date,
                            IsActive = true
                        };
                        db.InvoiceDetailReports.Add(invoiceDetailReport);
                    }
                }

                db.SaveChanges();

                return View();
            }
            catch (Exception)
            {
                throw;
            }
        }
    }
}