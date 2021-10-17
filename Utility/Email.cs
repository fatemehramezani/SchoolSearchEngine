using System.Configuration;
using System.Net;
using System.Net.Mail;

public class Email
{
    private  string context;
    private string subject;
    private string email;

    public Email(string subject,string context, string email)
    {
        this.subject = subject;
	    this.email = email;
	    this.context = context;
	}
    public void Send(string fromEmail, string smtpServer,string userName,string password)
    {     
            SmtpClient smtpClient = new SmtpClient(smtpServer);
            smtpClient.UseDefaultCredentials = false;
            smtpClient.Credentials = new NetworkCredential(userName, password);
            MailMessage mailMessage = new MailMessage();
            mailMessage.To.Add(new System.Net.Mail.MailAddress(email));
            mailMessage.From = new System.Net.Mail.MailAddress(fromEmail);
            mailMessage.Subject = subject;
            string strBody = "<html><body>" +
               " <b><font color=\"green\">بازدید کننده گرامی</font></b> <br/>"
               +subject +
               "<br/>"
               +context+
               "</body></html>";
            mailMessage.Body = strBody;
            mailMessage.IsBodyHtml = true;
     
            smtpClient.Send(mailMessage);
            mailMessage.Dispose();

            /*using System.Net;

using System.Net.Mail;

SmtpClient smtpClient = new SmtpClient();

NetworkCredential basicCredential =

    new NetworkCredential("username", "password");

MailMessage message = new MailMessage();

MailAddress fromAddress = new MailAddress("from@yourdomain.com");

smtpClient.Host = "mail.mydomain.com";

smtpClient.UseDefaultCredentials = false;

smtpClient.Credentials = basicCredential;

message.From = fromAddress;

message.Subject = "your subject";

//Set IsBodyHtml to true means you can send HTML email.

message.IsBodyHtml = true;

message.Body = "<h1>your message body</h1>";

message.To.Add("to@anydomain.com");

try

{

    smtpClient.Send(message);

}

catch(Exception ex)

{

    //Error, could not send the message

    Response.Write(ex.Message);

}*/
    }
}