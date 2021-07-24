using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;
using System.Linq;
using System.Web;
using WebModels;

namespace WEB.Models
{
    public class UserProfileViewModel
    {
        private string _userName = string.Empty;
        public int UserId { get; set; }
        public string StaffCode { get; set; }
        public string Role { get; set; }
        public int? StationID { get; set; }
        public string UserName
        {
            get { return _userName.Trim(); }
            set
            {
                if (!string.IsNullOrEmpty(value))
                {
                    _userName = value.Trim();
                }
            }
        }
        public string FullName { get; set; }
        public string Email { get; set; }
        public string Mobile { get; set; }
        public string Avatar { get; set; }
        public bool IsActive { get; set; }
        public string StationName { get; set; }
        public int CreatedBy { get; set; }
        public DateTime? CreatedAt { get; set; }
        public DateTime? ModifiedAt { get; set; }
        public virtual Station Station { get; set; }
    }
}