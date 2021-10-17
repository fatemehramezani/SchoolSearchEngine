using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace Role.Guest.School
{
    public partial class Information : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!Page.IsPostBack)
            {
                LoadSchoolInformation();
            }
        }
        void LoadSchoolInformation()
        {
            int SchoolId = -1;
            try
            {
                SchoolId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId]);
            }
            catch
            {
                SchoolId = -1;
            }
            if (SchoolId < 1)
                Response.Redirect("~/home");
            InformationRepeater.DataSource = new BusinessLayer.Common.SchoolInformations().GetByProperty(typeof(int), "Id", SchoolId.ToString()).ToList();
            InformationRepeater.DataBind();
        }
    }
}