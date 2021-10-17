using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SiteMaps_SiteMap : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
        {
            SetInformation();
        }
    }
    void SetInformation()
    {
        #region News
        var News = CachingLayer.Caching.GetFromCache("SiteMap_News") as List<DataLayer.News>;
        if (News == null)
        {
            News = new BusinessLayer.Common.News().Get().OrderBy(e => Guid.NewGuid()).ToList();
            CachingLayer.Caching.AddToCache("SiteMap_News", News, new TimeSpan(3, 0, 0, 0));
        }
        NewsRepeater.DataSource = News;
        NewsRepeater.DataBind();
        #endregion

        #region Blog
        var Blog = CachingLayer.Caching.GetFromCache("SiteMap_Blog") as List<DataLayer.Blog>;
        if (Blog == null)
        {
            Blog = new BusinessLayer.Common.Blogs().Get().OrderBy(e => Guid.NewGuid()).ToList();
            CachingLayer.Caching.AddToCache("SiteMap_Blog", Blog, new TimeSpan(3, 0, 0, 0));
        }
        BlogRepeater.DataSource = Blog;
        BlogRepeater.DataBind();
        #endregion

        #region Provience
        var Provience = CachingLayer.Caching.GetFromCache("SiteMap_Provience") as List<DataLayer.Location>;
        if (Provience == null)
        {
            Provience = new Service.CommonService().Locations(0).ToList();
            CachingLayer.Caching.AddToCache("SiteMap_Provience", Provience, new TimeSpan(7, 0, 0, 0));
        }
        ProvienceRepeater.DataSource = Provience;
        ProvienceRepeater.DataBind();
        #endregion

        #region City
        var City = CachingLayer.Caching.GetFromCache("SiteMap_City") as List<DataLayer.Location>;
        if (City == null)
        {
            City = new List<DataLayer.Location>();
            foreach (var p in Provience)
                City.AddRange(new Service.CommonService().Locations(p.Id).ToList());
            CachingLayer.Caching.AddToCache("SiteMap_City", City, new TimeSpan(7, 0, 0, 0));

        }
        CityRepeater.DataSource = City;
        CityRepeater.DataBind();
        #endregion

        #region Region
        var Region = CachingLayer.Caching.GetFromCache("SiteMap_Region") as List<DataLayer.Location>;
        if (Region == null)
        {
            Region = new List<DataLayer.Location>();
            foreach (var c in City)
                Region.AddRange(new Service.CommonService().Locations(c.Id).ToList());
            CachingLayer.Caching.AddToCache("SiteMap_Region", Region, new TimeSpan(7, 0, 0, 0));

        }
        RegionRepeater.DataSource = Region;
        RegionRepeater.DataBind();
        #endregion

        #region School
        var School = CachingLayer.Caching.GetFromCache("SiteMap_School") as List<DataLayer.Information>;
        if (School == null)
        {
            School = new BusinessLayer.School.SchoolInformations().Get().OrderBy(e => Guid.NewGuid()).ToList();
            CachingLayer.Caching.AddToCache("SiteMap_School", School, new TimeSpan(7, 0, 0, 0));
        }
        SchoolRepeater.DataSource = School;
        SchoolRepeater.DataBind();
        #endregion

        #region Common
        var Common = CachingLayer.Caching.GetFromCache("SiteMap_Common") as List<DataLayer.Common>;
        if (Common == null)
        {
            Common = new BusinessLayer.Common.Commons().Get().ToList();
            CachingLayer.Caching.AddToCache("SiteMap_Common", Common, new TimeSpan(7, 0, 0, 0));
        }
        CommonRepeater.DataSource = Common;
        CommonRepeater.DataBind();
        #endregion
    }
}