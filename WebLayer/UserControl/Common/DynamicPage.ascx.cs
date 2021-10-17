using System;
using System.Globalization;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Net.Mail;
using System.Web.UI.HtmlControls;
using System.Xml;
using BusinessLayer;
using DataLayer;
using System.Linq;
using System.Collections.Generic;

public partial class UserControl_Common_DynamicPage : System.Web.UI.UserControl
{
    public string Name = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Name))
            SetContent();
    }
    void SetContent()
    {
        var list = new BusinessLayer.Common.DynamicPages().GetByProperty(typeof(string), "Name", Name);
        if (list != null && list.Count() > 0)
        {
            DataLayer.DynamicPage selectedPage = list.First(); 
            string control = string.Empty;
            control += selectedPage.Content;
            HtmlGenericControl div = new HtmlGenericControl();
            div.ID = "containDiv";
            control = string.Format(@"<div>{0}</div>", control);
            div.InnerHtml = control;
            pageDiv.Controls.Add(div);
        }
    }
}