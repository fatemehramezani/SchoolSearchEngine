using System.Collections.Specialized;
using System.Configuration;
using DataLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
using System.Xml;
using System.Web.UI.HtmlControls;

public partial class Default : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Profile.UserName != null)
            {
                string[] roles = Roles.GetRolesForUser(Profile.UserName);
                if (roles.Contains("Administrator") || roles.Contains("Manager"))
                    Response.Redirect("~/Role/User/Default.aspx");
                else
                    Response.Redirect("~/UnauthorizedAccess.aspx");
            }
            else
                SetItem();
        }

    }
    private void SetItem()
    {      
    }
}