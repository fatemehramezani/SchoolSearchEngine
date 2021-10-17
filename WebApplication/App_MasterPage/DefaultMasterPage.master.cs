using System;
using System.Web.UI.HtmlControls;
using System.Xml;
namespace MasterPages
{
    public partial class DefaultMasterPage : BaseMasterPage
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
    }
}