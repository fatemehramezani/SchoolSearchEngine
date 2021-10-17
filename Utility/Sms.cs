namespace Utility
{
    public class Sms
    {
        private string context;

        public Sms(string context)
        {
            this.context = context;
        }
        public string[] SendSMS(string userName, string password, string[] phones, string sender)
        {
            return new string[4]; //new Send().SendSimpleSMS(userName, password, phones, sender, context, false);
        }
    }
}