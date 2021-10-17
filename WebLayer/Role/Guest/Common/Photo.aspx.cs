using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Guest_Photo : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            SetPhoto();
    }

    void SetPhoto()
    {
        int PhotoId = -1;
        try
        {
            PhotoId = int.Parse(Request.QueryString["Id"]);
        }
        catch
        {
            PhotoId = -1;
        }
        if (PhotoId <= 0)
            try { 
            PhotoId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values["Id"]);
            }
            catch
            {
                PhotoId = -1;
            }
        if (PhotoId <= 0)
            return;

        imagecontainer.InnerHtml = string.Empty;

        string imagePath = string.Format("../Files/Photo/{0}", PhotoId);
        string thumbnailPath = string.Format("../Files/Photo/{0}/Thumbnails", PhotoId);
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
	      	                             </li>", imagePath, files[i].Name.ToString(),thumbnailPath);
        string content = string.Format(@"<ul class=""gallery-items"">{0}</ul>", image);
        imagecontainer.InnerHtml = content;
    }
}