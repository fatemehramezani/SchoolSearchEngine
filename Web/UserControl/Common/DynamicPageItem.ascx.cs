using System;
using System.Activities.Statements;
using System.Configuration;
using System.Globalization;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Net.Mail;
using System.Web.UI.HtmlControls;
using System.Windows.Forms.VisualStyles;
using System.Xml;
using BusinessLayer;
using DataLayer;
using System.Linq;
using System.Collections.Generic;

public partial class UserControl_Common_DynamicPageItem : System.Web.UI.UserControl
{
    public string Name = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!string.IsNullOrEmpty(Name))
        {
            SetContent();
        }
    }
    void SetContent()
    {
        var list = new BusinessLayer.Common.DynamicPages().GetByProperty(typeof(string), "Name", Name);
        if (list != null && list.Count() > 0)
        {
            DataLayer.DynamicPage selectedPage = list.First();
            string control = string.Empty;
            control += selectedPage.Content;
            HtmlGenericControl div = new HtmlGenericControl();
            div.ID = "containDiv";
            control = string.Format(@"<div>{0}</div>", control);
            #region Set School Parameter
            try
            {
                int SchoolId = int.Parse(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId].ToString());
                if (SchoolId > 0)
                    control = SetSchoolParameter(control, SchoolId);
            }
            catch (Exception ex)
            {
            }
            #endregion
            div.InnerHtml = control;
            pageDiv.Controls.Add(div);
        }
    }
    string SetSchoolParameter(string control, int SchoolId)
    {
        DataLayer.Information currentSchool = new BusinessLayer.School.SchoolInformations().GetByProperty(typeof(int), "Id", SchoolId.ToString()).FirstOrDefault();

        return control
               .Replace("@SchoolId", currentSchool.Id.ToString())
               .Replace("@SchoolName", currentSchool.Name)
               .Replace("@SchoolPhone", currentSchool.Phone1)
               .Replace("@SchoolAddress", currentSchool.Address)
               .Replace("@LogoUrl", string.Format("{0}/{1}/{2}", Utility.Common.GetConfigValue("SchoolLogoUrl"), currentSchool.ApplicantId, currentSchool.LogoURL))
               .Replace("@BannerUrl", string.Format("{0}/{1}/{2}", Utility.Common.GetConfigValue("SchoolBannerUrl"), currentSchool.ApplicantId, currentSchool.BannerURL))
               .Replace("@DefaultLogo", string.Format("{0}/{1}", Utility.Common.GetConfigValue("SchoolLogoUrl"), "NoImage.png"));
    }
}