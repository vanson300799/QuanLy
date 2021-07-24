using Common;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web.Hosting;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;

namespace WEB.Areas.Admin.Controllers
{
    public class CostIncurredController : Controller
    {
        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        // GET: Admin/DetailImport
        public ActionResult Index()
        {
            var model = new CostIncurredViewModel();
            var currentUser = UserInfoHelper.GetUserData();

            if (currentUser.StationID.HasValue)
            {
                var shopName = db.Stations.Where(x => x.ID == currentUser.StationID).FirstOrDefault();
                model.StationName = shopName.StationName;
                model.StationID = currentUser.StationID;
            }
            return View(model);
        }
        [AllowAnonymous]
        public ActionResult CostIncurred_Read([DataSourceRequest] DataSourceRequest request, CostIncurredViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);

            var import = from bd in db.CostManages.Where(x => x.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.IsActive))
                         && EntityFunctions.TruncateTime(x.Date) <= EntityFunctions.TruncateTime(end) && EntityFunctions.TruncateTime(x.Date) >= EntityFunctions.TruncateTime(start))
                         join st in db.Stations on bd.StationID equals st.ID into group1

                         from item1 in group1.DefaultIfEmpty()
                         join us in db.UserProfiles on bd.Spend equals us.UserId into userspen

                         from item2 in userspen.DefaultIfEmpty()
                         join user in db.UserProfiles on bd.Recipient equals user.UserId into userreci

                         from item3 in userreci.DefaultIfEmpty()
                         select new CostIncurredViewModel
                         {
                             DateTime = (DateTime)bd.Date,
                             Note = bd.Note,
                             Money = bd.Money ?? default,
                             SpendName = item2.FullName,
                             RecipientName = item3.FullName,
                             StationName = item1.StationName
                         };
            var countlist = 1;
            List<CostIncurredViewModel> importlist = new List<CostIncurredViewModel>();

            foreach (var item in import)
            {
                CostIncurredViewModel list = new CostIncurredViewModel
                {
                    Count = countlist,
                    DateTime = item.DateTime,
                    Note = item.Note,
                    Money = item.Money,
                    SpendName = item.SpendName,
                    RecipientName = item.RecipientName,
                    StationName = item.StationName

                };
                countlist += 1;
                importlist.Add(list);
            }
            return Json(importlist, JsonRequestBehavior.AllowGet);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(CostIncurredViewModel model)
        {
            var result = DownloadCostIncurred(model);
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Chi_phi_phat_sinh.xlsx");
        }
        public byte[] DownloadCostIncurred(CostIncurredViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();

            CultureInfo provider = CultureInfo.InvariantCulture;
            var format = "dd-MM-yyyy";

            var start = DateTime.ParseExact(model.StartTime, format, provider);
            var end = DateTime.ParseExact(model.EndTime, format, provider);

            var import = from bd in db.CostManages.Where(x => x.IsActive && (currentUser.StationID.HasValue ? x.StationID == currentUser.StationID : (model.StationID.HasValue ? x.StationID == model.StationID : x.IsActive))
                         && EntityFunctions.TruncateTime(x.Date) <= EntityFunctions.TruncateTime(end) && EntityFunctions.TruncateTime(x.Date) >= EntityFunctions.TruncateTime(start))
                         join st in db.Stations on bd.StationID equals st.ID into group1

                         from item1 in group1.DefaultIfEmpty()
                         join us in db.UserProfiles on bd.Spend equals us.UserId into userspen

                         from item2 in userspen.DefaultIfEmpty()
                         join user in db.UserProfiles on bd.Recipient equals user.UserId into userreci

                         from item3 in userreci.DefaultIfEmpty()
                         select new CostIncurredViewModel
                         {
                             DateTime = (DateTime)bd.Date,
                             Note = bd.Note,
                             Money = bd.Money ?? default,
                             SpendName = item2.FullName,
                             RecipientName = item3.FullName,
                             StationName = item1.StationName
                         };
            var countlist = 1;
            List<CostIncurredViewModel> importlist = new List<CostIncurredViewModel>();

            foreach (var item in import)
            {
                CostIncurredViewModel list = new CostIncurredViewModel
                {
                    Count = countlist,
                    DateTime = item.DateTime,
                    Note = item.Note,
                    Money = item.Money,
                    SpendName = item.SpendName,
                    RecipientName = item.RecipientName,
                    StationName = item.StationName

                };
                countlist += 1;
                importlist.Add(list);
            }
            var fileinfo = new FileInfo(string.Format(@"{0}\CostIncurred.xlsx", HostingEnvironment.MapPath("/Uploads")));
            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    if (model.StationID.HasValue)
                    {
                        var station = db.Stations.Where(x => x.ID == model.StationID).FirstOrDefault();
                        productWorksheet.Cells[2, 1].Value = station.StationName.ToUpper();
                    }
                    else
                    {
                        productWorksheet.Cells[2, 1].Value = "Tất cả cửa hàng";
                    }
                    productWorksheet.Select();
                    productWorksheet.Cells[1, 1].Value = "BẢNG CHI PHÍ PHÁT SINH ";
                    productWorksheet.Cells[3, 1].Value = " TỪ " + model.Time.ToUpper();
                    var count = import.Count();
                    var modelTable = productWorksheet.Cells[1, 1, count + 6, 7];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    for (int i = 0; i < count; i++)
                    {
                        var productInfo = importlist[i];
                        productWorksheet.Cells[i + 5, 1].Value = productInfo.Count;
                        productWorksheet.Cells[i + 5, 2].Value = productInfo.DateTime;
                        productWorksheet.Cells[i + 5, 3].Value = productInfo.Note;
                        productWorksheet.Cells[i + 5, 4].Value = productInfo.Money;
                        productWorksheet.Cells[i + 5, 5].Value = productInfo.SpendName;
                        productWorksheet.Cells[i + 5, 6].Value = productInfo.RecipientName;
                        productWorksheet.Cells[i + 5, 7].Value = productInfo.StationName;

                        productWorksheet.Cells[i + 5, 4].Style.Numberformat.Format = "#,##0.00";
                    }
                    productWorksheet.Cells[count + 6, 3].Value = "TỔNG";
                    productWorksheet.Cells[count + 6, 4].Formula = "=SUM(" + productWorksheet.Cells[4, 4, count + 4, 4] + ")";

                    productWorksheet.Cells[count + 6, 1, count + 6, 7].Style.Font.Bold = true;
                    productWorksheet.Cells[count + 6, 4].Style.Numberformat.Format = "#,##0.00";
                    return p.GetAsByteArray();
                }
            }

            return null;
        }
    }
}