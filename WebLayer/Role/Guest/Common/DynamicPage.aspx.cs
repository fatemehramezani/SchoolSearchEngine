using System;
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


public partial class Guest_AboutUs : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            SetPage();
    }
    private void SetPage()
    {
        #region URL
        byte PageId = 0;
        try
        {
            PageId = byte.Parse(Request.QueryString["Id"]);
        }
        catch
        {
            PageId = 0;
        }
        if (PageId <= 0)
            try
            {
                PageId = Convert.ToByte(HttpContext.Current.Request.RequestContext.RouteData.Values["Id"]);
            }
            catch
            {
                PageId = 0;
            }
        #endregion
        if (PageId <= 0)
            return;
        List<DynamicPage> selectedPage = new DatabaseEntities().DynamicPage.Where(page => page.Id == PageId).ToList();
        if (selectedPage == null || selectedPage.Count() == 0)
            return;
        DynamicPageRepeater.DataSource = selectedPage;
        DynamicPageRepeater.DataBind();
    }
}