using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Login : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            if (Request.IsAuthenticated && !string.IsNullOrEmpty(Request.QueryString["ReturnUrl"]))
                //This is an unauthorized, authenticated request...
                Response.Redirect("~/UnauthorizedAccess.aspx");
        }
    }
    protected void LoginUser_LoggedIn(object sender, EventArgs e)
    {
        if (Roles.IsUserInRole(LoginUser.UserName, "Administrator"))
            Response.Redirect("~/Role/User/Default.aspx");
        else if (Roles.IsUserInRole(LoginUser.UserName, "Manager"))
            Response.Redirect("~/Role/User/Default.aspx");
        else if (Roles.IsUserInRole(LoginUser.UserName, "Content"))
            Response.Redirect("~/Role/User/Default.aspx");
        else if (Roles.IsUserInRole(LoginUser.UserName, "Marketing"))
            Response.Redirect("~/Role/User/Default.aspx");
        else
            Response.Redirect("~/Default.aspx");
    }
}