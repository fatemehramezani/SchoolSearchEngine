using System;
using System.Web.UI.HtmlControls;
using System.Xml;
namespace MasterPages
{
    public partial class DefaultMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            Page.Theme = "Default";
        }
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                UserSiteMapDataSource.SiteMapProvider = "Default";
            }
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
            Page.Title = title;
            Page.MetaKeywords = keywords;
            Page.MetaDescription = description;
        }
        #endregion
    }
}