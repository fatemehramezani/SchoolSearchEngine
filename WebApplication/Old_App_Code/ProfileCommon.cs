using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace WebApplication
{
    public class ProfileCommon
    {
        public DataLayer.Applicant Applicant
        {
            get
            {
                return (Teachers)HttpContext.Current.Profile.GetPropertyValue("Applicant");
            }
            set
            {
                HttpContext.Current.Profile.SetPropertyValue("Applicant", value);
            }
        }
    }
}