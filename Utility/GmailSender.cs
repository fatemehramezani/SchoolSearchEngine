using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Net;
using System.Net.Mail;

namespace Utility
{
    public class GmailSender
    {
        public GmailSender()
        {
            //
            // TODO: Add constructor logic here
            //
        }

        public static bool SendMail(string gMailAccount, string password, string to, string subject, string message,string smtpServer,int port)
        {
            try
            {
                NetworkCredential loginInfo = new NetworkCredential(gMailAccount, password);
                MailMessage msg = new MailMessage();
                msg.From = new MailAddress(gMailAccount);
                msg.To.Add(new MailAddress(to));
                msg.Subject = subject;
                msg.Body = message;
                msg.IsBodyHtml = true;
                SmtpClient client = new SmtpClient(smtpServer);
                client.Port = port;
                client.EnableSsl = true;
                client.UseDefaultCredentials = false;
                client.Credentials = loginInfo;
                client.Send(msg);

                return true;
            }
            catch (Exception)
            {
                return false;
            }

        }
    }
}
