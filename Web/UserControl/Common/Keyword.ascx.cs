using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserControl_Common_Keyword : System.Web.UI.UserControl
{
    private void LoadKeyword()
    {
        var list = CachingLayer.Caching.GetFromCache("Keywords") as List<DataLayer.Common>;
        if (list == null)
        {
            list = new BusinessLayer.Common.Commons().Get().ToList();
            CachingLayer.Caching.AddToCache("Keywords", list, new TimeSpan(24, 0, 0));
        }
        DataLayer.Common common = new DataLayer.Common
        {
            Title = "مدرسه",
            Id = int.MaxValue
        };

        list.Insert(0, common);

        keywordRepeater.DataSource = list.Distinct().Select(e => new DataLayer.Common { Id = e.Id, Title = e.Title.Replace("_", " ") }).OrderBy(e => Guid.NewGuid()).Take(5);
        keywordRepeater.DataBind();
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        LoadKeyword();
    }
}