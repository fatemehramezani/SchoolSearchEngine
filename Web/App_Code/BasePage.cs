using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
/// <summary>
/// Summary description for BasePage
/// </summary>
public partial class BasePage : System.Web.UI.Page
{
    public void SetSeo(string title, string description, string keyword,string itemDescription)
    {
        if (string.IsNullOrEmpty(description) && itemDescription.Length > 150)
            description = itemDescription.Substring(0,150);
        if (string.IsNullOrEmpty(keyword) && itemDescription.Length > 150)
        {
            keyword = Utility.Common.WordHighFrequency(itemDescription);
            if (keyword.Length > 50)
                keyword = keyword.Substring(0,50);
        }        
        ((BaseMasterPage)this.Master).SetSEOSetting(title, description, keyword);
    }
}