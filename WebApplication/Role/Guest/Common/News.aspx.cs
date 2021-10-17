using DataLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Guest_News : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            SetNews();
    }

    private void SetNews()
    {
        #region News
        string NewsImagePath = "../Files/News/Images";
        string NewsFilePath = "../Files/News/Files";
        string category = string.Empty;
        DatabaseEntities _DatabaseEntities = new DatabaseEntities();
        foreach (News News in _DatabaseEntities.News)
        {
            category += string.Format(@"<li><a href=""../خبر/{0}/{1}""><h5>{1}</h5></a></li>",News.Id,News.Title);
        }
        NewsContainer.InnerHtml = category;
        #endregion
        int NewsId = -1;
        try
        {
            NewsId = int.Parse(Request.QueryString["Id"]);
        }
        catch
        {
            NewsId = -1;
        }
        if (NewsId <= 0)
            try { 
            NewsId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values["Id"]);
            }
            catch
            {
                NewsId = -1;
            }
        if (NewsId <= 0)
            return;
        News selectedNews = _DatabaseEntities.News.FirstOrDefault(News => News.Id == NewsId);
        if (selectedNews != null)
        {
            NewsContent.InnerHtml = string.Format(@"<article class=""post hentry format-image"">
  	                                                        <header class=""entry-header"">
		                                                        <h1 class=""entry-title"">{0}</h1>
		                                                        <div class=""entry-meta"">
      		                                                        <div class=""entry-format"">
        		                                                        <span class=""image-format"">image</span>
        	                                                        </div>
      		                                                        <span class=""sep""> | </span>
      		                                                        <time class=""entry-date"">{1}</time>
      		                                                        <span class=""sep""> | </span>	
      		                                                        <span class=""cat-links""> <a href=""{2}/{3}"">دانلود فایل</a></span>
      		                                                        <span class=""sep""> | </span>
     	                                                        </div>
                                                            </header>
                                                            <div class=""entry-content"">
                                                              <div class=""full-size"">
      	                                                        <img src=""{4}/{5}"" alt=""{0}"">
                                                              </div>
                                                              <p>{6}</p>
 	                                                        </div>    
                                                          </article>",
                 selectedNews.Title,
                 selectedNews.Date.ToLongDateString(),
                 NewsFilePath,
                 selectedNews.FileUrl,
                 NewsImagePath,
                 string.IsNullOrEmpty(selectedNews.ImageUrl) ? "NoImage.png" : selectedNews.ImageUrl,
                 selectedNews.Description);
        }
    }
}