using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Xml;
using System.Xml.Linq;

public partial class Role_Guest_Common_RSS : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            this.PopulateRssFeed();
    }
    private void PopulateRssFeed()
    {
        string rssFeedUrls = Utility.Common.GetConfigValue("RssFeedUrl");
        string[] rssFeedUrlList = rssFeedUrls.Split(';');
        List<Feeds> feeds = new List<Feeds>();
        int rssCount = int.Parse(Utility.Common.GetConfigValue("RSSCount"));
        foreach (var rssFeedUrl in rssFeedUrlList)
        {
            if (string.IsNullOrEmpty(rssFeedUrl))
                continue;
            try
            {
                XDocument xDoc = XDocument.Load(rssFeedUrl);
                var items = (from x in xDoc.Descendants("item")
                             select new
                             {
                                 title = x.Element("title") != null ? x.Element("title").Value : string.Empty,
                                 link = x.Element("link") != null ? x.Element("link").Value : string.Empty,
                                 pubDate = x.Element("pubDate") != null ? x.Element("pubDate").Value : string.Empty,
                                 description = x.Element("description") != null ? x.Element("description").Value : string.Empty
                             });
                if (items != null)
                {
                    feeds.AddRange(items.Select(i => new Feeds
                    {
                        Title = i.title,
                        Link = i.link,
                        PublishDate = i.pubDate,
                        Description = i.description
                    }).Where(n => n.Description.Length > 20).OrderByDescending(m => m.Description.Length).Take(rssCount));
                }
            }
            catch (System.Exception ex)
            {
            }
        }
        RssRepeater.DataSource = feeds;//.OrderBy(f=>f.);
        RssRepeater.DataBind();
    }
}
public class Feeds
{
    public string Title { get; set; }
    public string Link { get; set; }
    private string publishDate;
    public string PublishDate
    {
        get
        {
            return publishDate;
        }
        set
        {
            if (!string.IsNullOrEmpty(value) && value.Length > 10)
                try
                {
                    publishDate = Utility.PersianDateConvertor.ToPersianDate(DateTime.Parse(value),"{yyyy/MM/dd}");
                }
                catch (System.Exception ex)
                {
                    publishDate = value;
                }
            else
                publishDate = value;
        }
    }
    public string Description { get; set; }
}