using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Data.Entity.Core.Objects;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Web.Hosting;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;

namespace WEB.Areas.Admin.Controllers
{
    public class GeneralImportController : Controller
    {
        WebContext db = new WebContext();
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        // GET: Admin/GeneralImport
        public ActionResult Index()
        {
            return View();
        }

        [Obsolete]
        public ActionResult GeneralImportRead([DataSourceRequest] DataSourceRequest request, ImportModel model)
        {

            DateTime timeStart = DateTime.ParseExact(model.StartTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
            DateTime timeEnd = DateTime.ParseExact(model.EndTime, "dd-MM-yyyy", CultureInfo.InvariantCulture);
             var countView = 0;
             var import = from im in db.ImportOrderDetails.Where(x => x.IsActive && x.ImportOrder.IsActive
                          && (model.ProductID.HasValue ? x.ProductID == model.ProductID : x.IsActive)
                         && DbFunctions.TruncateTime(x.Date) <= DbFunctions.TruncateTime(timeEnd) && DbFunctions.TruncateTime(x.Date) >= DbFunctions.TruncateTime(timeStart))

                         join pr in db.Products.Where(x => x.IsActive) on im.ProductID equals pr.ID into group1
                         from item1 in group1.DefaultIfEmpty()

                         join st in db.Stations.Where(x => x.IsActive) on im.StationID equals st.ID into group2
                         from item2 in group2.DefaultIfEmpty()

                         select new GeneralImportViewModel()
                         {
                             ProductName = item1.ProductName,
                             ProductID = im.ProductID,
                             StationID = im.ID,
                             StationName = item2.StationName,
                             CostPrice = im.InputPrice * im.InputNumber * (decimal)1.1,
                             Weigh = im.InputNumber
                         };
            var temp = import.ToList();
            List<GeneralImportViewModel> resultf = new List<GeneralImportViewModel>();
            var importCheckgroup = import.GroupBy(x => x.StationID).ToList();
            foreach (var item in importCheckgroup)
            {
                decimal weightContent = 0;
                decimal costPriceContent = 0;
                var station = item.FirstOrDefault();

                foreach (var itemcontent in item.ToList())
                {
                    weightContent += itemcontent.Weigh;
                    costPriceContent += itemcontent.CostPrice;
                }
                countView += 1;
                GeneralImportViewModel itemlist = new GeneralImportViewModel
                {
                    Count = countView,
                    StationName = station.StationName,
                    Weigh = weightContent,
                    CostPrice = costPriceContent
                };
                resultf.Add(itemlist);
            }
            if (import == null)
            {
                List<GeneralImportViewModel> importNull = new List<GeneralImportViewModel>();

                return Json(importNull.ToList(), JsonRequestBehavior.AllowGet);
            }

            return Json(resultf.ToList(), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult ExportExcel(ExcelImportViewModel model)
        {
            var checkProduct = from p in db.Products select p.ID;
            if (!checkProduct.Contains(model.ProductID??default) && model.ProductID != null)
            {
                ModelState.AddModelError("", WebResources.InputComboboxProductID);
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }
            if (ModelState.IsValid)
            {
                List<ExcelImportViewModel> listData = new List<ExcelImportViewModel>();
                ExcelImportViewModel nulldata = new ExcelImportViewModel();
                if (model.DataExport != "[]")
                {
                    var dataListJson = model.DataExport.Replace('?', '"');
                    var dataObjSplit0 = dataListJson.Split('[');
                    var dataObjSplit1 = dataObjSplit0[1].Split('}');
                    for (var i = 0; i < (dataObjSplit1.Count() - 1); i++)
                    {
                        if (i == 0)
                        {
                            string dataObjString = dataObjSplit1[i] + "}";
                            ExcelImportViewModel dataObj = JsonConvert.DeserializeObject<ExcelImportViewModel>(dataObjString);

                            listData.Add(dataObj);
                        }
                        else
                        {
                            var dataObjString0 = dataObjSplit1[i].Substring(1);
                            string dataObjString = dataObjString0 + "}";
                            ExcelImportViewModel dataObj = JsonConvert.DeserializeObject<ExcelImportViewModel>(dataObjString);

                            listData.Add(dataObj);
                        }
                    }
                }
                else
                {
                    listData.Add(nulldata);
                }
                listData[0].Time = model.Time;
                listData[0].ProductID = model.ProductID;
                var result = DownloadGeneral(listData);
                var fileStream = new MemoryStream(result);
                return File(fileStream, "application/ms-excel", "Nhap_hang_tong_hop.xlsx");
            }
            else
            {
                return new HttpStatusCodeResult(HttpStatusCode.InternalServerError);
            }

        }
        public byte[] DownloadGeneral(List<ExcelImportViewModel> models)
        {
            var currentUser = UserInfoHelper.GetUserData();

            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            var fileinfo = new FileInfo(string.Format(@"{0}\GeneralImport.xlsx", HostingEnvironment.MapPath("/Uploads")));
            if (fileinfo.Exists)
            {
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    productWorksheet.Select();

                    var modelTable = productWorksheet.Cells[1, 1, models.Count() + 7, 4];
                    productWorksheet.Cells[1, 1].Value = "BẢNG THEO DÕI NHẬP HÀNG TỔNG HỢP";
                    productWorksheet.Cells[2, 1].Value = "Từ " + models[0].Time.ToUpper();
                    if (models[0].ProductID.HasValue)
                    {
                        productWorksheet.Cells[3, 1].Value = models[0].ProductName;
                    }
                    else
                    {
                        productWorksheet.Cells[3, 1].Value = "Hàng Hóa: Tất cả";
                    }
                    productWorksheet.Cells[1, 1].Style.Font.Bold = true;
                    productWorksheet.Cells[2, 1].Style.Font.Bold = true;
                    productWorksheet.Cells[3, 1].Style.Font.Bold = true;

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    if (models.Count != 0)
                    {
                        for (int i = 0; i < models.Count; i++)
                        {
                            var productInfo = models[i];
                            productWorksheet.Cells[i + 6, 1].Value = productInfo.Count;
                            productWorksheet.Cells[i + 6, 2].Value = productInfo.StationName;

                            productWorksheet.Cells[i + 6, 3].Value = productInfo.Weigh;
                            productWorksheet.Cells[i + 6, 3].Style.Numberformat.Format = "#,##0.00";
                            productWorksheet.Cells[i + 6, 4].Value = productInfo.CostPrice;
                            productWorksheet.Cells[i + 6, 4].Style.Numberformat.Format = "#,##0.00";

                        }
                        productWorksheet.Cells[models.Count + 7, 2].Value = "Tổng";
                        productWorksheet.Cells[models.Count + 7, 2].Style.Font.Bold = true;
                        productWorksheet.Cells[models.Count + 7, 3].Formula = "=SUM(" + productWorksheet.Cells[6, 3, models.Count + 5, 3] + ")";
                        productWorksheet.Cells[models.Count + 7, 4].Formula = "=SUM(" + productWorksheet.Cells[6, 4, models.Count + 5, 4] + ")";
                        productWorksheet.Cells[models.Count + 7, 3].Style.Font.Bold = true;
                        productWorksheet.Cells[models.Count + 7, 4].Style.Font.Bold = true;
                        productWorksheet.Cells[models.Count + 7, 3].Style.Numberformat.Format = "#,##0.00";
                        productWorksheet.Cells[models.Count + 7, 4].Style.Numberformat.Format = "#,##0.00";
                        return p.GetAsByteArray();
                    }
                    else
                    {
                        return p.GetAsByteArray();
                    }

                }
            }
            else
            {
                return null;
            }
        }
    }

}