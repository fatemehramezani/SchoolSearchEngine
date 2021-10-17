using DataLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class Guest_News : BasePage
{
    void Page_PreInit(Object sender, EventArgs e)
    {
        int SchoolId;
        try
        {
            SchoolId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId]);
        }
        catch
        {
            SchoolId = -1;
        }
        if (SchoolId > 0)
            this.MasterPageFile = "~/App_MasterPage/SchoolMasterPage.master";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            SetNews();
    }

    private void SetNews()
    {
        #region Parameters
        #region News
        int NewsId = -1;
        try
        {
            NewsId = int.Parse(Request.QueryString[Utility.Common.NewsId]);
        }
        catch
        {
            NewsId = -1;
        }
        if (NewsId <= 0)
            try
            {
                NewsId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.NewsId]);
            }
            catch
            {
                NewsId = -1;
            }
        #endregion
        #region School
        int SchoolId = -1;
        try
        {
            SchoolId = int.Parse(Request.QueryString[Utility.Common.SchoolId]);
        }
        catch
        {
            SchoolId = -1;
        }
        if (SchoolId <= 0)
            try
            {
                SchoolId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId]);
            }
            catch
            {
                SchoolId = -1;
            }
        #endregion
        #endregion

        #region NewsList
        int PageSize = 5;
        try
        {
            PageSize = Int16.Parse(Utility.Common.GetConfigValue("PageSize"));
        }
        catch
        {
        }
        var list = GetNews(SchoolId);
        pagingControl.PageSize = PageSize;
        pagingControl.RecordCount = list.Count;
        NewsListRepeater.DataSource = list.Skip((pagingControl.PageIndex - 1) * pagingControl.PageSize).Take(pagingControl.PageSize);
        NewsListRepeater.DataBind();
        #endregion

        #region SelectedNews
        if (NewsId <= 0)
            return;
        var selectedNewss = new BusinessLayer.Common.News().GetByProperty(typeof(int), "Id", NewsId.ToString()).ToList();
        NewsRepeater.DataSource = selectedNewss;
        NewsRepeater.DataBind();
        #endregion

        #region SEO
        try
        {
            News selectedNews = selectedNewss.FirstOrDefault();
            SetSeo(selectedNews.Title, selectedNews.PageDescription, selectedNews.PageKeyword, selectedNews.Description);
            Page.Title = selectedNews.Title;
        }
        catch (Exception ex)
        {
        }
        #endregion
    }
    private List<News> GetNews(int SchoolId)
    {
        if (SchoolId < 1)
        {
            var list = new BusinessLayer.Common.MainSite.News().Get().Select(b => new { b.Id, b.Title });
            return list.ToList().Select(b => new News { Id = b.Id, Title = b.Title }).ToList();
        }
        else
            return new BusinessLayer.Common.News().GetByProperty(typeof(int), "SchoolId", SchoolId.ToString()).ToList();
    }
}