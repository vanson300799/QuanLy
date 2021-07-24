using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WEB.WebHelpers;
using WebModels;

namespace WEB.Models
{
    public class AddLogSystem
    {
        public static void AddLog(LogSystem log)
        {
            using (var webcontext = new WebContext())
            {
                var currentUser = UserInfoHelper.GetUserData();
                if (currentUser.UserId != 0)
                {
                    log.CreatedBy = currentUser.UserId;
                    log.UserID = currentUser.UserId;
                }
                log.CreatedAt = DateTime.Now;
                webcontext.LogSystems.Add(log);
                webcontext.SaveChanges();
            }
        }
    }
}
