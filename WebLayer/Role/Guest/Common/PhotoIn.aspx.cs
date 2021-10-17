using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Guest_PhotoIn : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        imagecontainer.InnerHtml = string.Empty;
        if (string.IsNullOrEmpty(Request.QueryString["Id"]))
            return;
        string imagePath = string.Format("../Files/Photo/{0}/Image", Request.QueryString["Id"]);
        string thumbnailPath = string.Format("../Files/Photo/{0}/Thumbnails", Request.QueryString["Id"]);
        DirectoryInfo directory = new DirectoryInfo(Server.MapPath(imagePath));
        if (!directory.Exists)
            return;
        FileInfo[] files = directory.GetFiles();
        if (files.Length > 0)
            for (int i = 0; i < files.Length; i++)
                imagecontainer.InnerHtml +=
                    string.Format(
                        @"<li><a href=""#""><img src=""{0}/{1}"" data-large=""{2}/{1}"" alt=""image{3}"" data-description=""تصویر شماره {3}"" /></a></li>",
                        thumbnailPath, files[i].Name.ToString(), imagePath, i + 1);
    }
}