﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using WebModels;
using WebModels.Constants;

namespace WEB.WebHelpers
{
    public class UserInfoHelper
    {
        public static void SetUserData(UserProfile userProfile)
        {
            // save user info into session
            HttpContext.Current.Session[SessionKeyConstant.USER_DATA] = userProfile;
        }

        public static UserProfile GetUserData()
        {
            // get user info from session
            var userInfo = HttpContext.Current.Session[SessionKeyConstant.USER_DATA];
            if (userInfo != null)
            {
                return userInfo as UserProfile;
            }
            else if (HttpContext.Current.User.Identity.IsAuthenticated)
            {
                using (var dbContext = new WebContext())
                {
                    var user = dbContext.UserProfiles.Where(x => x.UserName == HttpContext.Current.User.Identity.Name).FirstOrDefault();
                    HttpContext.Current.Session[SessionKeyConstant.USER_DATA] = user;
                    return user;
                }
            }

            return new UserProfile();
        }
    }
}