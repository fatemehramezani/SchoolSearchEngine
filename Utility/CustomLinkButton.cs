using System;
using System.Data;
using System.Configuration;
using System.Web;
using System.Web.Security;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.WebControls.WebParts;
using System.Web.UI.HtmlControls;

/// <summary>
/// Summary description for MyLinkButton
/// </summary>
namespace Utility
{
    public class CustomLinkButton : Label
    {
        private Image im;
        private Label li;
        private string url;
        public CustomLinkButton()
            : base()
        {
            base.Text = "";
            li = new Label();
            im = new Image();
            im.ImageAlign = ImageAlign.Middle;
            this.Controls.Add(im);
            this.Controls.Add(li);
            this.Text = "<a href=''></a>";
            url = "";
        }
        public CustomLinkButton(string fileName, string path)
            : base()
        {
            //
            // TODO: Add constructor logic here
            //
            base.Text = "";
            li = new Label();
            li.Text = fileName;
            im = new Image();
            im.ImageUrl = string.Format("{0}\\{1}", path, fileName);
            im.ImageAlign = ImageAlign.Middle;
            this.Controls.Add(im);
            this.Controls.Add(li);
            url = "";
        }
        public ImageAlign ImageAlign
        {
            get
            {
                return im.ImageAlign;
            }
            set
            {
                im.ImageAlign = value;
            }
        }
        public string ImageUrl
        {
            set
            {
                im.ImageUrl = value;
            }
            get
            {
                return im.ImageUrl;
            }
        }
        public override string Text
        {
            get
            {
                return li.Text;
            }
            set
            {
                li.Text = value;
            }
        }
        public string Url
        {
            get
            {
                return url;
            }
            set
            {
                url = value;
                li.Text = "<a href='" + url + "' class='" + this.CssClass + "'>" + li.Text + "</a>";
            }
        }
        /* protected override void OnClick(EventArgs e)
         {
             base.OnClick(e);
             if (url != "")
                 Page.Response.Redirect(url);
         }*/
    }
}