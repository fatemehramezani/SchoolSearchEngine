using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
namespace MasterPages
{
    public partial class SchoolMasterPage : System.Web.UI.MasterPage
    {
        protected String PageTitle, PageDescription, PageKeywords;

        protected void Page_Load(object sender, EventArgs e)
        {

        }
        #region SetSEOSetting
        public void SetSEOSetting(String title, String description, String keywords)
        {
            if (String.IsNullOrEmpty(title))
                title = Utility.Common.GetConfigValue(Utility.Common.Title);
            if (String.IsNullOrEmpty(description))
                description = Utility.Common.GetConfigValue(Utility.Common.Description);
            if (String.IsNullOrEmpty(keywords))
                keywords = Utility.Common.GetConfigValue(Utility.Common.Keyword);
            PageTitle = title;
            PageDescription = description;
            PageKeywords = keywords;
        }
        #endregion
    }
}