using AutoMapper;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data.Entity;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web.Hosting;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;
using WebModels.Constants;
using LicenseContext = OfficeOpenXml.LicenseContext;

namespace WEB.Areas.Admin.Controllers
{
    [PetroAuthorizeAttribute]
    public class DebtManageController : Controller
    {
        // GET: Admin/DebtManage
        WebContext db = new WebContext();

        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult Add()
        {
            var model = new DebtManageViewModel();
            var currentMaxId = db.DebtManages.Where(x => x.IsActive == true).Select(x => x.DealCode).Max();
            if (currentMaxId != null)
            {
                var currentMaxNumber = int.Parse(currentMaxId.Replace("CN", ""));
                model.DealCode = string.Format("CN{0}", (currentMaxNumber + 1).ToString().PadLeft(6, '0'));
            }
            else
            {
                model.DealCode = "CN000001";
            }
            model.DateString = DateTime.Now.ToString("dd/MM/yyyy HH:mm");

            return View(model);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] DebtManageViewModel model)
        {
            var currentUser = UserInfoHelper.GetUserData();
            if (!string.IsNullOrEmpty(model.DateString))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.Date = DateTime.ParseExact(model.DateString, format, provider);
            }

            if (ModelState.IsValid)
            {
                var temp = (from p in db.Set<DebtManage>().AsNoTracking()
                            where p.IsActive == true && p.DealCode.Equals(model.DealCode, StringComparison.OrdinalIgnoreCase)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    ModelState.AddModelError("", "Mã số giao dịch đã tồn tại!");
                    return View(model);
                }
                else
                {
                    DebtManage debtManage = new DebtManage();
                    debtManage.IsActive = true;
                    debtManage.CreatedBy = currentUser.UserId;
                    debtManage.CreatedAt = DateTime.Now;
                    debtManage.CustomerID = model.CustomerID;
                    debtManage.StationID = model.StationID;
                    debtManage.Date = model.Date;
                    debtManage.DealCode = model.DealCode;
                    debtManage.Note = model.Note;
                    debtManage.Money = model.Money;

                    db.Set<DebtManage>().Add(debtManage);

                    db.SaveChanges();
                    var debtManageChangeJson = model.ToJson();
                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.ADD_DEBTMANAGE_ACTION,
                        FunctionName = DataFunctionNameConstant.ADD_DEBTMANAGE_FUNCTION,
                        DataTable = DataTableConstant.DEBT_MANAGE,
                        Information = debtManageChangeJson
                    };

                    AddLogSystem.AddLog(log);
                    ViewBag.StartupScript = "create_success();";
                    return View(model);
                }
            }
            else
            {
                return View(model);
            }
        }
        public ActionResult Edit(int id)
        {
            var model = db.Set<DebtManage>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            var config = new MapperConfiguration(cfg => cfg.CreateMap<DebtManage, DebtManageViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<DebtManageViewModel>(model);
            viewModel.CurrentCode = model.DealCode;
            viewModel.DateString = viewModel.Date.ToString("dd/MM/yyyy HH:mm");
            var number = model.Money;
            string stringMoney = String.Format("{0:#,##0.##}", number);
            viewModel.StringMoney = stringMoney;
            return View("Edit", viewModel);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(DebtManageViewModel model)
        {
            var oldDebtManage = db.DebtManages.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
            var oldJson = oldDebtManage.ToJson();
            if (!string.IsNullOrEmpty(model.DateString))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.Date = DateTime.ParseExact(model.DateString, format, provider);
            }

            var currentUser = UserInfoHelper.GetUserData();

            if (ModelState.IsValid)
            {
                var current = db.DebtManages.FirstOrDefault(x => x.IsActive && x.ID == model.ID);
                var temp = (from p in db.Set<DebtManage>().AsNoTracking()
                            where (p.DealCode.Equals(model.DealCode, StringComparison.OrdinalIgnoreCase) && p.DealCode != current.DealCode)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    ModelState.AddModelError("", "Mã số giao dịch đã tồn tại!");
                    return View(model);
                }
                else
                {
                    try
                    {
                        current.Date = model.Date;
                        current.DealCode = model.DealCode;
                        current.Note = model.Note;
                        current.CustomerID = model.CustomerID;
                        current.Money = model.Money;
                        current.ModifiedAt = DateTime.Now;
                        current.ModifiedBy = currentUser.UserId;
                        current.StationID = model.StationID;

                        db.SaveChanges();
                        var newDebtManage = db.DebtManages.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
                        var newJson = oldDebtManage.ToJson();
                        LogSystem log = new LogSystem
                        {
                            ActiveType = DataActionTypeConstant.UPDATE_DEBTMANAGE_ACTION,
                            FunctionName = DataFunctionNameConstant.UPDATE_DEBTMANAGE_FUNCTION,
                            DataTable = DataTableConstant.DEBT_MANAGE,
                            Information = string.Format("Trước khi thay đổi: {0} Sau khi thay đổi: {1}", oldJson, newJson)
                        };
                        AddLogSystem.AddLog(log);

                        ViewBag.StartupScript = "edit_success();";

                        return View(model);
                    }
                    catch (Exception ex)
                    {
                        ModelState.AddModelError("", ex.Message);
                        return View(model);
                    }
                }
            }
            else
            {
                return View(model);
            }

        }

        [AllowAnonymous]
        public ActionResult DebtManage_Read([DataSourceRequest] DataSourceRequest request)
        {
            var users = from dm in db.DebtManages.Where(x => x.IsActive == true)
                        join st in db.Stations on dm.StationID equals st.ID into group1
                        from item1 in group1.DefaultIfEmpty()

                        join ct in db.Customers on dm.CustomerID equals ct.ID into group2
                        from item2 in group2.DefaultIfEmpty()

                        select new DebtManageViewModel()
                        {
                            ID = dm.ID,
                            StationName = item1.StationName,
                            Date = dm.Date,
                            DealCode = dm.DealCode,
                            CustomerName = item2.CustomerName,
                            Money = dm.Money,
                            Note = dm.Note
                        };
            return Json(users.ToDataSourceResult(request));
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult DebtManage_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<DebtManage> models)
        {
            var debtManageChange = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.DebtManages.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_DEBT_MANAGE_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_DEBT_MANAGE_FUNCTION,
                DataTable = DataTableConstant.DEBT_MANAGE,
                Information = debtManageChange
            };

            AddLogSystem.AddLog(log);

            return Json(models.ToDataSourceResult(request));
        }

        [HttpPost]
        public ActionResult ExportExcel(DebtManageViewModel data)
        {

            List<DebtManageViewModel> listData = new List<DebtManageViewModel>();
            var dataListJson = data.DataExport.Replace('?', '"');
            var dataObjSplit0 = dataListJson.Split('[');
            var dataObjSplit1 = dataObjSplit0[1].Split('}');
            for (var i = 0; i < (dataObjSplit1.Count() - 1); i++)
            {
                DebtManageViewModel dataObj = null;
                var dataObjString = string.Empty;
                if (i == 0)
                {
                    dataObjString = dataObjSplit1[i] + "}";
                }
                else
                {
                    var dataObjString0 = dataObjSplit1[i].Substring(1);
                    dataObjString = dataObjString0 + "}";
                }
                dataObj = JsonConvert.DeserializeObject<DebtManageViewModel>(dataObjString);
                dataObj.Date = dataObj.Date.ToLocalTime();
                listData.Add(dataObj);
            }
            var result = DownloadDebtManage(listData.OrderByDescending(x => x.Date).ToList());
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Quan_Ly_Cong_No.xlsx");
        }

        public byte[] DownloadDebtManage(List<DebtManageViewModel> models)
        {

            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            var fileinfo = new FileInfo(string.Format(@"{0}\DebtManage.xlsx", HostingEnvironment.MapPath("/Uploads")));
            if (fileinfo.Exists)
            {
                var countView = 0;
                foreach (var item in models)
                {
                    countView += 1;
                    item.Count = countView;
                }
                using (var p = new ExcelPackage(fileinfo))
                {
                    // export products
                    var productWorksheet = p.Workbook.Worksheets[0];
                    productWorksheet.Select();
                    productWorksheet.Cells[1, 1].Value = "QUẢN LÝ CÔNG NỢ";
                    //border
                    var modelTable = productWorksheet.Cells[1, 1, models.Count() + 3, 6];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    if (models.Count != 0)
                    {
                        for (int i = 0; i < models.Count(); i++)
                        {
                            productWorksheet.Cells[i + 4, 1].Value = models[i].Date;
                            productWorksheet.Cells[i + 4, 2].Value = models[i].DealCode;
                            productWorksheet.Cells[i + 4, 3].Value = models[i].Note;
                            productWorksheet.Cells[i + 4, 4].Value = models[i].CustomerName;
                            productWorksheet.Cells[i + 4, 5].Value = models[i].Money;
                            productWorksheet.Cells[i + 4, 6].Value = models[i].StationName;

                            productWorksheet.Cells[i + 4, 5].Style.Numberformat.Format = "#,##0.00";
                        }

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