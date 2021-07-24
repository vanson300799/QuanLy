using AutoMapper;
using Kendo.Mvc.Extensions;
using Kendo.Mvc.UI;
using System;
using System.Collections.Generic;
using System.Data.Entity;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using WEB.Models;
using WEB.WebHelpers;
using WebModels;
using WebModels.Constants;

namespace WEB.Areas.Admin.Controllers
{

    public class NoteBookKeyController : Controller
    {
        // GET: Admin/NoteBookKey
        WebContext db = new WebContext();
        //private static bool UpdateDatabase = false;
        protected override void Dispose(bool disposing)
        {
            db.Dispose();
            base.Dispose(disposing);
        }
        public ActionResult Index()
        {
            return View();
        }
        public ActionResult NoteBookKey_Read([DataSourceRequest] DataSourceRequest request)
        {
            var users = from x in db.NoteBookKeys.Where(x => x.IsActive == true)
                        join sc in db.UserProfiles on x.ModifiedBy equals sc.UserId into leftjoin
                        from lj in leftjoin.DefaultIfEmpty()
                        select new NoteBookKeyViewModel
                        {
                            ID = x.ID,
                            DateTimeKey = (DateTime)x.DateTimeKey,
                            ModifiedName = lj != null ? lj.FullName : string.Empty,
                            ModifiedAt = (DateTime)x.ModifiedAt
                        };
            return Json(users.ToDataSourceResult(request));
        }

        public ActionResult Edit(int id)
        {
            var model = db.Set<NoteBookKey>().Find(id);
            if (model == null)
            {
                return HttpNotFound();
            }
            var config = new MapperConfiguration(cfg => cfg.CreateMap<NoteBookKey, NoteBookKeyViewModel>());
            IMapper iMapper = config.CreateMapper();
            var viewModel = iMapper.Map<NoteBookKeyViewModel>(model);
            viewModel.DateString = viewModel.DateTimeKey.ToString("dd/MM/yyyy HH:mm");

            return View("Edit", viewModel);
        }
        [HttpPost]
        [ValidateAntiForgeryToken]
        [ValidateInput(false)]
        public ActionResult Edit([Bind(Include = "")] NoteBookKeyViewModel model)
        {
            var oldNotBookKey = db.NoteBookKeys.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
            if (!string.IsNullOrEmpty(model.DateString))
            {
                CultureInfo provider = CultureInfo.InvariantCulture;
                var format = "dd/MM/yyyy HH:mm";
                model.DateTimeKey = DateTime.ParseExact(model.DateString, format, provider);
            }

            var currentUser = UserInfoHelper.GetUserData();
            if (ModelState.IsValid)
            {
                try
                {
                    List<NoteBookKey> list = new List<NoteBookKey>();

                    var noteBookKey = new NoteBookKey
                    {
                        ID = model.ID,
                        DateTimeKey = model.DateTimeKey,  
                        ModifiedAt = DateTime.Now,
                        ModifiedBy = currentUser.UserId,
                    };
                    list.Add(noteBookKey);
                    foreach (var item in list)
                    {
                        db.NoteBookKeys.Attach(item);
                        db.Entry(item).Property(a => a.ID).IsModified = false;
                        db.Entry(item).Property(a => a.DateTimeKey).IsModified = true;
                        db.Entry(item).Property(a => a.ModifiedAt).IsModified = true;
                        db.Entry(item).Property(a => a.ModifiedBy).IsModified = true;
                        db.SaveChanges();
                    }
                    var newNoteBookKey = db.NoteBookKeys.Where(x => x.ID == model.ID).AsNoTracking().FirstOrDefault();
                    var noteBookKeyChange = new List<NoteBookKey>();
                    noteBookKeyChange.Add(oldNotBookKey);
                    noteBookKeyChange.Add(newNoteBookKey);
                    var noteBookKeyChangeJson = noteBookKeyChange.ToJson();
                    LogSystem log = new LogSystem
                    {
                        ActiveType = DataActionTypeConstant.UPDATE_NOTEBOOKKEY_ACTION,
                        FunctionName = DataFunctionNameConstant.UPDATE_NOTE_BOOK_KEY_FUNCTION,
                        DataTable = DataTableConstant.NOTE_BOOK_KEY,
                        Information = noteBookKeyChangeJson
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
            else
            {
                return View(model);
            }
        }
        //public ActionResult NoteBookKey_Update([DataSourceRequest] DataSourceRequest request,
        //    [Bind(Prefix = "models")] IEnumerable<NoteBookKeyViewModel> models)
        //{
        //    List<NoteBookKey> list = new List<NoteBookKey>();
        //    var currentUser = UserInfoHelper.GetUserData();
        //    foreach (var product in models)
        //    {
        //        var noteBookKey = new NoteBookKey();
        //        noteBookKey.ID = product.ID;
        //        noteBookKey.DateTimeKey = product.DateTimeKey;
        //        noteBookKey.ModifiedBy = currentUser.UserId;
        //        noteBookKey.ModifiedAt = DateTime.Now;
        //        list.Add(noteBookKey);
        //    }

        //    foreach (var product in list)
        //    {
        //        db.NoteBookKey.Attach(product);
        //        db.Entry(product).Property(a => a.ID).IsModified = false;
        //        db.Entry(product).Property(a => a.DateTimeKey).IsModified = true;
        //        db.Entry(product).Property(a => a.ModifiedBy).IsModified = true;
        //        db.Entry(product).Property(a => a.ModifiedAt).IsModified = true;
        //        db.SaveChanges();
        //    }

        //LogSystem log = new LogSystem
        //{
        //    ActiveType = DataActionTypeConstant.UPDATE_NOTE_BOOK_KEY_ACTION,
        //    FunctionName = DataFunctionNameConstant.UPDATE_NOTE_BOOK_KEY_FUNCTION,
        //    DataTable = DataTableConstant.NOTE_BOOK_KEY
        //};

        //    AddLogSystem.AddLog(log);

        //    return Json(models.ToDataSourceResult(request, ModelState));
        //}
    }
}