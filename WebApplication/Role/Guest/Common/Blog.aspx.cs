using DataLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class Guest_Blog : BasePage
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
            SetBlog();
    }

    private void SetBlog()
    {
        #region Parameters
        #region Blog
        int BlogId = -1;
        try
        {
            BlogId = int.Parse(Request.QueryString[Utility.Common.BlogId]);
        }
        catch
        {
            BlogId = -1;
        }
        if (BlogId <= 0)
            try
            {
                BlogId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.BlogId]);
            }
            catch
            {
                BlogId = -1;
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

        #region BlogList
        BlogListRepeater.DataSource = GetBlog(SchoolId);
        BlogListRepeater.DataBind();
        #endregion

        #region SelectedBlog
        if (BlogId <= 0)
            return;
        var selectedBlogs = new BusinessLayer.Common.Blogs().GetByProperty(typeof(int), "Id", BlogId.ToString()).ToList();
        BlogRepeater.DataSource = selectedBlogs;
        BlogRepeater.DataBind();
        #endregion

        #region SEO
        try
        {
            Blog selectedBlog = selectedBlogs.FirstOrDefault();
            SetSeo(selectedBlog.Title,selectedBlog.PageDescription,selectedBlog.PageKeyword,selectedBlog.Description);
            Page.Title = selectedBlog.Title;            
        }
        catch(Exception ex)
        {
        }
        #endregion
    }
    private List<Blog> GetBlog(int SchoolId)
    {
        if (SchoolId < 1)
        {
            var list = new BusinessLayer.Common.MainSite.Blogs().Get().Select(b => new { b.Id, b.Title });
            return list.ToList().Select(b => new Blog { Id = b.Id, Title = b.Title }).ToList();
        }
        else
            return new BusinessLayer.Common.Blogs().GetByProperty(typeof(int), "SchoolId", SchoolId.ToString()).ToList();
    }
}