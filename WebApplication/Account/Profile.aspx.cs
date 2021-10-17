using System;
using System.Collections.Generic;
using System.Configuration;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;
using System.IO;
using System.Web.UI.HtmlControls;

public partial class Account_Profile : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
            LoadApplicant();
    }
    void LoadApplicant()
    {
        FirstNameTextBox.Text = Profile.FirstName;
        LastNameTextBox.Text = Profile.LastName;
        MobileTextBox.Text = Profile.Mobile;
        PhoneTextBox.Text = Profile.Phone;
        EmailTextBox.Text = Profile.Email;
    }
    protected void ConfirmButton_Click(object sender, EventArgs e)
    {
        DatabaseEntities databaseEntities = new DatabaseEntities(ConfigurationManager.ConnectionStrings["DatabaseEntities"].ToString());
        User newUser = databaseEntities.User.First(user => user.Username == Profile.UserName);
        newUser.FirstName = FirstNameTextBox.Text;
        newUser.LastName = LastNameTextBox.Text;
        newUser.Mobile = MobileTextBox.Text;
        newUser.Phone = PhoneTextBox.Text;
        newUser.Email = EmailTextBox.Text;
        databaseEntities.SaveChanges();
        //Applicant buyer = databaseEntities.Applicants.FirstOrDefault(item => item.UserId == newUser.Id);
        //if (buyer == null)
        //    buyer = new Applicant();
        //Profile.SetPropertyValue("ApplicantId", buyer.Id);
        Profile.SetPropertyValue("LastName", LastNameTextBox.Text);
        Profile.SetPropertyValue("FirstName", FirstNameTextBox.Text);
        Profile.SetPropertyValue("FullName", FirstNameTextBox.Text + " " + LastNameTextBox.Text);
        Profile.SetPropertyValue("Mobile", MobileTextBox.Text);
        Profile.SetPropertyValue("Phone", PhoneTextBox.Text);
        Profile.SetPropertyValue("Email", EmailTextBox.Text);

        databaseEntities.SaveChanges();
        Response.Redirect("~/Role/User/Default.aspx");
    }
}