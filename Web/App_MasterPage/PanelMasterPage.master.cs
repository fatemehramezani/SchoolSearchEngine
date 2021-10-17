using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace MasterPages
{
    public partial class PanelMasterPage : System.Web.UI.MasterPage
    {
        protected void Page_PreInit(object sender, EventArgs e)
        {
            Page.Theme = "Panel";
        }

        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                if (Profile.UserName == null)
                    Response.Redirect("~/Default.aspx");
                else
                {
                    string[] roles = Roles.GetRolesForUser(Profile.UserName);
                    if (roles.Contains("Administrator"))
                        UserSiteMapDataSource.SiteMapProvider = "Administrator";
                    else if (roles.Contains("Manager"))
                        UserSiteMapDataSource.SiteMapProvider = "Manager";
                    else if (roles.Contains("Content"))
                        UserSiteMapDataSource.SiteMapProvider = "Content";
                    else if (roles.Contains("Marketing"))
                        UserSiteMapDataSource.SiteMapProvider = "Marketing";
                    else
                        Response.Redirect("~/UnauthorizedAccess.aspx");
                }
            }
        }
    }
}