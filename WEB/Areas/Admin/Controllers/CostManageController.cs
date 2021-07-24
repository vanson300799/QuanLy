using AutoMapper;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using Newtonsoft.Json;
using OfficeOpenXml;
using OfficeOpenXml.Style;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;
using WebModels.Constants;

namespace WEB.Areas.Admin.Controllers
{
    [PetroAuthorizeAttribute]
    public class CostManageController : Controller
    {
        // GET: Admin/CostManage
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
            var model = new CostManageViewModel();
            var currentMaxId = db.CostManages.Where(x=> x.IsActive == true).Select(x => x.NumberArises).Max();
            if (currentMaxId != null)
            {
                var currentMaxNumber = int.Parse(currentMaxId.Replace("CP", ""));
                model.NumberArises = string.Format("CP{0}", (currentMaxNumber + 1).ToString().PadLeft(6, '0'));
            }
            else
            {
                model.NumberArises = "CP000001";
            }
            model.DateString = DateTime.Now.ToString("dd/MM/yyyy HH:mm");

            return View(model);
        }

        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Add([Bind(Exclude = "")] CostManageViewModel model)
        {
            var costManagerChangeJson = model.ToJson();
            var currentUser = UserInfoHelper.GetUserData();

            if (!string.IsNullOrEmpty(model.DateString))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.Date = DateTime.ParseExact(model.DateString, format, provider);
            }

            if (ModelState.IsValid)
            {
                var temp = (from p in db.Set<CostManage>().AsNoTracking()
                            where p.IsActive == true && p.NumberArises.Equals(model.NumberArises, StringComparison.OrdinalIgnoreCase)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    ModelState.AddModelError("", "Mã số phát sinh đã tồn tại!");
                    return View(model);
                }
                else
                {
                    CostManage costManage = new CostManage();
                    costManage.IsActive = true;
                    costManage.CreatedBy = currentUser.UserId;
                    costManage.CreatedAt = DateTime.Now;
                    costManage.StationID = model.StationID;
                    costManage.Date = model.Date;
                    costManage.NumberArises = model.NumberArises;
                    costManage.Note = model.Note?.Trim();
                    costManage.Money = model.Money;
                    costManage.Spend = model.Spend;
                    costManage.Recipient = model.Recipient;
                    db.Set<CostManage>().Add(costManage);

                    db.SaveChanges();
                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.ADD_COSTMANAGE_ACTION,
                        FunctionName = DataFunctionNameConstant.ADD_COSTMANAGE_FUNCTION,
                        DataTable = DataTableConstant.COST_MANAGE,
                        Information = costManagerChangeJson
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
            var model = db.Set<CostManage>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            var config = new MapperConfiguration(cfg => cfg.CreateMap<CostManage, CostManageViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<CostManageViewModel>(model);
            viewModel.DateString = viewModel.Date.ToString("dd/MM/yyyy HH:mm");
            viewModel.CurrentCode = model.NumberArises;
            var number = model.Money;
            string stringMoney = String.Format("{0:#,##0.##}", number);
            viewModel.StringMoney = stringMoney;
            return View("Edit", viewModel);
        }
        [HttpPost]
        [ValidateInput(false)]
        public ActionResult Edit(CostManageViewModel model)
        {
            var oldCostManage = db.CostManages.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
            var oldJson = oldCostManage.ToJson();
            if (!string.IsNullOrEmpty(model.DateString))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.Date = DateTime.ParseExact(model.DateString, format, provider);
            }

            var currentUser = UserInfoHelper.GetUserData();

            if (ModelState.IsValid)
            {
                var temp = (from p in db.Set<CostManage>().AsNoTracking()
                            where p.IsActive == true && (p.NumberArises.Equals(model.NumberArises, StringComparison.OrdinalIgnoreCase) && p.NumberArises != model.CurrentCode)
                            select p).FirstOrDefault();
                if (temp != null)
                {
                    ModelState.AddModelError("", "Mã số phát sinh đã tồn tại!");
                    return View(model);
                }
                else
                {
                    try
                    {
                        CostManage costManage = new CostManage()
                        {
                            Date = model.Date,
                            NumberArises = model.NumberArises,
                            ID = model.ID,
                            Note = model.Note?.Trim(),
                            Money = model.Money,
                            ModifiedAt = DateTime.Now,
                            ModifiedBy = currentUser.UserId,
                            StationID = model.StationID,
                            Recipient = model.Recipient,
                            Spend = model.Spend,
                        };

                        db.CostManages.Attach(costManage);
                        db.Entry(costManage).Property(a => a.ID).IsModified = false;
                        db.Entry(costManage).Property(a => a.Date).IsModified = true;
                        db.Entry(costManage).Property(a => a.NumberArises).IsModified = true;
                        db.Entry(costManage).Property(a => a.Note).IsModified = true;
                        db.Entry(costManage).Property(a => a.Recipient).IsModified = true;
                        db.Entry(costManage).Property(a => a.Spend).IsModified = true;
                        db.Entry(costManage).Property(a => a.Money).IsModified = true;
                        db.Entry(costManage).Property(a => a.ModifiedAt).IsModified = true;
                        db.Entry(costManage).Property(a => a.ModifiedBy).IsModified = true;
                        db.Entry(costManage).Property(a => a.StationID).IsModified = true;
                        db.SaveChanges();
                        var newJson = model.ToJson();
                        LogSystem log = new LogSystem
                        {
                            ActiveType = DataActionTypeConstant.UPDATE_COSTMANAGE_ACTION,
                            FunctionName = DataFunctionNameConstant.UPDATE_COSTMANAGE_FUNCTION,
                            DataTable = DataTableConstant.COST_MANAGE,
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
        public ActionResult CostManage_Read([DataSourceRequest] DataSourceRequest request)
        {
            var users = from cost in db.CostManages.Where(x => x.IsActive == true)
                        join st in db.Stations on cost.StationID equals st.ID into group1
                        from item1 in group1.DefaultIfEmpty()

                        join us in db.UserProfiles on cost.Spend equals us.UserId into userspen
                        from item2 in userspen.DefaultIfEmpty()

                        join user in db.UserProfiles on cost.Recipient equals user.UserId into userreci
                        from item3 in userreci.DefaultIfEmpty()
                        select new CostManageViewModel()
                        {
                            ID = cost.ID,
                            SpendCode = item2.StaffCode,
                            SpendName = item2.FullName,
                            NumberArises = cost.NumberArises,
                            Date = cost.Date,
                            RecipientCode = item3.StaffCode,
                            RecipientName = item3.FullName,
                            Money = cost.Money,
                            Note = cost.Note,
                            StationName = item1.StationName
                        };
            var jsonResult = Json(users.OrderByDescending(x => x.ID).ToDataSourceResult(request));
            jsonResult.MaxJsonLength = int.MaxValue;
            return jsonResult;
        }

        [AcceptVerbs(HttpVerbs.Post)]
        public ActionResult CostManage_Destroy([DataSourceRequest] DataSourceRequest request,
            [Bind(Prefix = "models")] IEnumerable<CostManage> models)
        {
            var costManageChangeJson = models.ToJson();
            foreach (var model in models)
            {
                var removingObjects = db.CostManages.FirstOrDefault(x => x.ID == model.ID);
                removingObjects.IsActive = false;
            }

            db.SaveChanges();
            LogSystem log = new LogSystem
            {
                ActiveType = DataActionTypeConstant.DELETE_COST_MANAGE_ACTION,
                FunctionName = DataFunctionNameConstant.DELETE_COST_MANAGE_FUNCTION,
                DataTable = DataTableConstant.COST_MANAGE,
                Information = costManageChangeJson
            };

            AddLogSystem.AddLog(log);

            return Json(models.ToDataSourceResult(request));
        }

        [AllowAnonymous]
        public JsonResult GetRecipientName(string text)
        {
            var shop = from x in db.UserProfiles.AsNoTracking()
                       where (x.IsActive == true)
                       select x;
            if (!string.IsNullOrEmpty(text))
            {
                shop = shop.Where(p => p.StaffCode.Contains(text) || p.FullName.Contains(text));
            }

            return Json(shop.ToList().Select(x => new
            {
                ID = x.UserId,
                Recipient = x.UserId,
                SpendName = x.FullName,
                SpendCode = x.StaffCode,
                RecipientDisplayName = string.Format("{0} : {1}", x.StaffCode, x.FullName)
            }), JsonRequestBehavior.AllowGet);
        }

        [AllowAnonymous]
        public JsonResult GetSpendName(string text)
        {
            var shop = from x in db.UserProfiles.AsNoTracking()
                       where (x.IsActive == true)
                       select x;
            if (!string.IsNullOrEmpty(text))
            {
                shop = shop.Where(p => p.StaffCode.Contains(text) || p.FullName.Contains(text));
            }

            return Json(shop.ToList().Select(x => new
            {
                ID = x.UserId,
                Spend = x.UserId,
                SpendName = x.FullName,
                SpendCode = x.StaffCode,
                SpendDisplayName = string.Format("{0} : {1}", x.StaffCode, x.FullName)
            }), JsonRequestBehavior.AllowGet);
        }

        [HttpPost]
        public ActionResult ExportExcel(CostManageViewModel data)
        {

            List<CostManageViewModel> listData = new List<CostManageViewModel>();
            if(data.DataExport != "[]")
            {
                var dataListJson = data.DataExport.Replace('?', '"');
                var dataObjSplit0 = dataListJson.Split('[');
                var dataObjSplit1 = dataObjSplit0[1].Split('}');
                for (var i = 0; i < (dataObjSplit1.Count() - 1); i++)
                {
                    CostManageViewModel dataObj = null;
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
                    dataObj = JsonConvert.DeserializeObject<CostManageViewModel>(dataObjString);
                    dataObj.Date = dataObj.Date.ToLocalTime();
                    listData.Add(dataObj);
                }
            }
            else
            {
                CostManageViewModel datanull = new CostManageViewModel();
                listData.Add(datanull);
            }
            var result = DownloadCostManage(listData.OrderByDescending(x => x.Date).ToList());
            var fileStream = new MemoryStream(result);
            return File(fileStream, "application/ms-excel", "Quan_Ly_Chi_Phi.xlsx");
        }

        public byte[] DownloadCostManage(List<CostManageViewModel> models)
        {

            ExcelPackage.LicenseContext = LicenseContext.Commercial;
            var fileinfo = new FileInfo(string.Format(@"{0}\CostManage.xlsx", HostingEnvironment.MapPath("/Uploads")));
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
                    productWorksheet.Cells[1, 1].Value = "QUẢN LÝ CHI PHÍ";
                    //border
                    var modelTable = productWorksheet.Cells[1, 1, models.Count() + 3, 7];

                    modelTable.Style.Border.Top.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Left.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Right.Style = ExcelBorderStyle.Thin;
                    modelTable.Style.Border.Bottom.Style = ExcelBorderStyle.Thin;
                    if (models.Count != 0)
                    {
                        for (int i = 0; i < models.Count(); i++)
                        {
                            productWorksheet.Cells[i + 4, 1].Value = models[i].Date;
                            productWorksheet.Cells[i + 4, 2].Value = models[i].NumberArises;
                            productWorksheet.Cells[i + 4, 3].Value = models[i].SpendName;
                            productWorksheet.Cells[i + 4, 4].Value = models[i].RecipientName;
                            productWorksheet.Cells[i + 4, 5].Value = models[i].StationName;
                            productWorksheet.Cells[i + 4, 6].Value = models[i].Money;
                            productWorksheet.Cells[i + 4, 7].Value = models[i].Note;


                            productWorksheet.Cells[i + 4, 6].Style.Numberformat.Format = "#,##0.00";
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