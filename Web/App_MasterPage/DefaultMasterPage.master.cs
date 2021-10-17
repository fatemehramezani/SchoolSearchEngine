using System;
using System.Web.UI.HtmlControls;
using System.Xml;
public partial class MasterPages_DefaultMasterPage : BaseMasterPage
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