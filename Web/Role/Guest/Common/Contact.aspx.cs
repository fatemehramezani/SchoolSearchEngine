using System;
using System.Activities.Statements;
using System.Configuration;
using System.Globalization;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Net.Mail;
using System.Windows.Forms.VisualStyles;
using BusinessLayer;
using DataLayer;
using System.Linq;
using System.Collections.Generic;


public partial class Guest_Contact : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
    }

    protected void SendButton_OnClickImageButton_Click(object sender, EventArgs e)
    {
        string strBody = string.Format(@"<html><body> <b><font color=""green"">مدیر گرامی</font></b> <br/>
                                           {0}  با ایمیل {1} و موضوع {2} برای شما این پیام را ارسال نموده است:
                                           <br/> {3}
                                           </body></html>", FullName.Text, Email.Text, Subject.Text, Description.Text);
        Email email = new Email(Subject.Text, strBody,Email.Text);
        email.Send(ConfigurationManager.AppSettings["Email"], ConfigurationManager.AppSettings["SmtpServer"], ConfigurationManager.AppSettings["EmailUserName"], ConfigurationManager.AppSettings["EmailPassword"]);
    }
}