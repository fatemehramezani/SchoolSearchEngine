using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;
public partial class Register : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Request.QueryString["ReturnUrl"] != null)
            RegisterUser.ContinueDestinationPageUrl = Request.QueryString["ReturnUrl"];
    }
    protected void RegisterUser_CreatedUser(object sender, EventArgs e)
    {
        if (Request.QueryString["Roles"] == null)
            Roles.AddUserToRole(RegisterUser.UserName, "Manager");
        else
        {
            //Convert.ToBase64String(System.Text.Encoding.ASCII.GetBytes(x))
            string[] roles = (System.Text.Encoding.ASCII.GetString(Convert.FromBase64String(Request.QueryString["Roles"]))).Split(';');
            Roles.AddUserToRoles(RegisterUser.UserName, roles.Where(role => role != string.Empty).ToArray());
        }
        FormsAuthentication.SetAuthCookie(RegisterUser.UserName, false);
        SetManagerProfile();
        CreatedUser();
    }
    private void SetManagerProfile()
    {
        DatabaseEntities databaseEntities = new DatabaseEntities(ConfigurationManager.ConnectionStrings["DatabaseEntities"].ToString());
        User newUser = databaseEntities.User.First(user => user.Username == RegisterUser.UserName);
        newUser.Email = ((TextBox)RegisterUserWizardStep.Controls[0].FindControl("Email")).Text;

        if (newUser.Applicant == null || newUser.Applicant.Count == 0)
        {
            Applicant applicant = new Applicant { Email = newUser.Email };
            applicant.User = newUser;

            databaseEntities.Applicant.Add(applicant);
            databaseEntities.SaveChanges();
        }
        if (newUser.Applicant != null)
        {
            ProfileCommon profile = Profile.GetProfile(newUser.Username);
            profile.ApplicantId = newUser.Applicant.FirstOrDefault().Id;
            profile.Email = newUser.Email;
            profile.UserId = newUser.Id;
            profile.Save();
        }
    }
    protected void ContinueButton_Click(object sender, EventArgs e)
    {
        CreatedUser();
    }
    private void CreatedUser()
    {
        string continueUrl = RegisterUser.ContinueDestinationPageUrl;
        if (String.IsNullOrEmpty(continueUrl))
        {
            continueUrl = "~/Account/Profile.aspx";
        }
        Response.Redirect(continueUrl);
    }
}
