using System.Web.UI.WebControls;
namespace Utility
{
    public class CustomImageButton : Label
    {
        //private string _url;
        public CustomImageButton(string imgUrl, string Url)
            : base()
        {
            //this.ImageUrl = imgUrl;
            //_url = Url;        
            this.Text = "<a href='" + Url + "'><img src='" + imgUrl + "' alt='' style='border:0px'/></a>";

        }
        public CustomImageButton(string imgUrl, string Url, string alt)
            : base()
        {
            if (Url.Trim() != "")
                this.Text = "<a  href='" + Url + "'><img src='" + imgUrl + "' alt='" + alt + "' style='border:0px'/></a>";
            else
                this.Text = "<img src='" + imgUrl + "' alt='" + alt + "' style='border:0px'/>";
        }
    }
}