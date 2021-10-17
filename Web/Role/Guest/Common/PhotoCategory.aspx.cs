using DataLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;
using System.IO;
public partial class Guest_PhotoCategory : BasePage
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
            SetPhotoCategory();
    }

    private void SetPhotoCategory()
    {
        #region Parameters
        #region PhotoCategory
        int PhotoCategoryId = -1;
        try
        {
            PhotoCategoryId = int.Parse(Request.QueryString[Utility.Common.PhotoCategoryId]);
        }
        catch
        {
            PhotoCategoryId = -1;
        }
        if (PhotoCategoryId <= 0)
            try
            {
                PhotoCategoryId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.PhotoCategoryId]);
            }
            catch
            {
                PhotoCategoryId = -1;
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

        #region PhotoCategoryList
        int PageSize = 5;
        try
        {
            PageSize = Int16.Parse(Utility.Common.GetConfigValue("PageSize"));
        }
        catch
        {
        }
        var list = GetPhotoCategory(SchoolId);
        pagingControl.PageSize = PageSize;
        pagingControl.RecordCount = list.Count;
        PhotoCategoryListRepeater.DataSource = list.Skip((pagingControl.PageIndex - 1) * pagingControl.PageSize).Take(pagingControl.PageSize);
        PhotoCategoryListRepeater.DataBind();
        #endregion

        #region SelectedPhotoCategory
        if (PhotoCategoryId <= 0)
            return;

        var selectedPhotoCategories = new BusinessLayer.Common.PhotoCategories().GetByProperty(typeof(int), "Id", PhotoCategoryId.ToString()).ToList();

        imagecontainer.InnerHtml = string.Empty;

        string imagePath = string.Format("{0}/{1}",Utility.Common.GetConfigValue("PhotoCategoryUrl"), PhotoCategoryId);
        string thumbnailPath = string.Format("{0}/Thumbnails/{1}", Utility.Common.GetConfigValue("PhotoCategoryUrl"), PhotoCategoryId);

        DirectoryInfo directory = new DirectoryInfo(Server.MapPath(imagePath));
        if (!directory.Exists)
            return;
        string image = string.Empty;
        string thumb = string.Empty;

        FileInfo[] files = directory.GetFiles();
        if (files.Length > 0)
            for (int i = 0; i < files.Length; i++)
                image += string.Format(@"<li class=""item"">
                                            <h5>
	      		                                <a href=""{0}/{1}"" class=""view"" rel=""gallery"" title=""Transparent Flower"">
	      			                                <span class=""overlay zoom""></span>
	      			                                <img src=""{2}/{1}"" alt="""">
	      		                                </a>
                                            </h5>
	      	                             </li>", imagePath, files[i].Name.ToString(), thumbnailPath);
        string content = string.Format(@"<ul class=""gallery-items"">{0}</ul>", image);
        imagecontainer.InnerHtml = content;
        #endregion

        #region SEO
        try
        {
            PhotoCategory selectedPhotoCategory = selectedPhotoCategories.FirstOrDefault();
            SetSeo(selectedPhotoCategory.Title,selectedPhotoCategory.PageDescription,selectedPhotoCategory.PageKeyword,string.Empty);
            Page.Title = selectedPhotoCategory.Title;            
        }
        catch(Exception ex)
        {
        }
        #endregion
    }
    private List<PhotoCategory> GetPhotoCategory(int SchoolId)
    {
        if (SchoolId < 1)
        {
            var list = new BusinessLayer.Common.MainSite.PhotoCategories().Get().Select(b => new { b.Id, b.Title });
            return list.ToList().Select(b => new PhotoCategory { Id = b.Id, Title = b.Title }).ToList();
        }
        else
            return new BusinessLayer.Common.PhotoCategories().GetByProperty(typeof(int), "SchoolId", SchoolId.ToString()).ToList();
    }
}