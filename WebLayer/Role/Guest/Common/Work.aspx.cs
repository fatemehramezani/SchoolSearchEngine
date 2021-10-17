using DataLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Guest_Work : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            SetWork();
    }

    private void SetWork()
    {
        #region Work
        string WorkImagePath = "../Files/Work/Images";
        string category = string.Empty;
        DatabaseEntities _DatabaseEntities = new DatabaseEntities();
        foreach (Work Work in _DatabaseEntities.Work)
        {
            category += string.Format(@"<li><a href=""../work/{0}""><h5>{1}</h5></a></li>",
                   Work.Id,
                   Work.Title);
        }
        WorkContainer.InnerHtml = category;
        #endregion
        int WorkId = -1;
        try
        {
            WorkId = int.Parse(Request.QueryString["Id"]);
        }
        catch
        {
            WorkId = -1;
        }
        if (WorkId <= 0)
            try { 
            WorkId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values["Id"]);
            }
            catch
            {
                WorkId = -1;
            }
        if (WorkId <= 0)
            return;
        Work selectedWork = _DatabaseEntities.Work.FirstOrDefault(Work => Work.Id == WorkId);
        if (selectedWork != null)
        {
            WorkContent.InnerHtml = string.Format(@"
                                                        <article class=""post hentry format-image"">
  	                                                        <header class=""entry-header"">
		                                                        <h1 class=""entry-title"">{0}</h1>
		                                                        <div class=""entry-meta"">
      		                                                        <div class=""entry-format"">
        		                                                        <span class=""image-format"">image</span>
        	                                                        </div>
      		                                                        <span class=""sep""> | </span>
      		                                                        <time class=""entry-date"">{1}</time>
      		                                                        <span class=""sep""> | </span>	
                                                                    <time class=""entry-date"">{2}</time>
      		                                                        <span class=""sep""> | </span>
     	                                                        </div>
                                                            </header>
                                                            <div class=""entry-content"">
                                                              <div class=""full-size"">
      	                                                        <img src=""{3}/{4}"" alt=""{0}"">
                                                              </div>
                                                              <p>{5}</p>
 	                                                        </div>    
                                                          </article>",
                 selectedWork.Title,
                 selectedWork.StartDate.HasValue ? selectedWork.StartDate.Value.ToLongDateString() : string.Empty,
                 selectedWork.EndDate.HasValue ? selectedWork.EndDate.Value.ToLongDateString() : string.Empty,
                 WorkImagePath,
                 string.IsNullOrEmpty(selectedWork.Image) ? "NoImage.png" : selectedWork.Image,
                 selectedWork.Description);
        }
    }
}