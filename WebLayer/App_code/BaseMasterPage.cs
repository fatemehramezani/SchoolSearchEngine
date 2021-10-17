using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for BaseMasterPage
/// </summary>
public class BaseMasterPage: System.Web.UI.MasterPage
{
    public String PageTitle, PageDescription, PageKeywords;
    #region SetSEOSetting
    public void SetSEOSetting(String title, String description, String keywords)
    {
        if (String.IsNullOrEmpty(title))
            title = Utility.Common.GetConfigValue(Utility.Common.Title);
        if (String.IsNullOrEmpty(description))
            description = Utility.Common.GetConfigValue(Utility.Common.Description);
        if (String.IsNullOrEmpty(keywords))
            keywords = Utility.Common.GetConfigValue(Utility.Common.Keyword);
        PageTitle = title + "Hello";
        PageDescription = description + "1111111";
        PageKeywords = keywords + "222222222";
    }
    #endregion
}