using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.IO;
public partial class MasterPages_SchoolMasterPage : BaseMasterPage
{
    protected String PageTitle, PageDescription, PageKeywords;

    protected void Page_Load(object sender, EventArgs e)
    {
        try
        {
            SchoolIdHiddenField.Value = HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId].ToString();
            DataLayer.Information currentSchool = new BusinessLayer.School.SchoolInformations().GetByProperty(typeof(int), "Id", SchoolIdHiddenField.Value).FirstOrDefault();
            SchoolNameHiddenField.Value = currentSchool.Name;
            //Server.MapPath(
            //string bannerPath = string.Format("{0}/{1}/{2}", Utility.Common.GetConfigValue("SchoolBannerUrl"), currentSchool.ApplicantId, currentSchool.BannerURL);
            //if(File.Exists(bannerPath))
            //    schoolBanner.Src = bannerPath;
        }
        catch(Exception ex)
        {

        }
    }
    #region SetSEOSetting
    public void SetSEOSetting(String title, String description, String keywords)
    {
        if (String.IsNullOrEmpty(title))
            title = Utility.Common.GetConfigValue(Utility.Common.Title);
        if (String.IsNullOrEmpty(description))
            description = Utility.Common.GetConfigValue(Utility.Common.Description);
        if (String.IsNullOrEmpty(keywords))
            keywords = Utility.Common.GetConfigValue(Utility.Common.Keyword);
        PageTitle = title;
        PageDescription = description;
        PageKeywords = keywords;
    }
    #endregion
}