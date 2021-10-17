using DataLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class Guest_Teacher : BasePage
{
    void Page_PreInit(Object sender, EventArgs e)
    {
        int SchoolId;
        try
        {
            SchoolId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId]);
        }
        catch
        {
            SchoolId = -1;
        }
        if (SchoolId > 0)
            this.MasterPageFile = "~/App_MasterPage/SchoolMasterPage.master";
    }
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!Page.IsPostBack)
            SetTeacher();
    }

    private void SetTeacher()
    {
        #region Parameters
        #region Teacher
        int TeacherId = -1;
        try
        {
            TeacherId = int.Parse(Request.QueryString[Utility.Common.TeacherId]);
        }
        catch
        {
            TeacherId = -1;
        }
        if (TeacherId <= 0)
            try
            {
                TeacherId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.TeacherId]);
            }
            catch
            {
                TeacherId = -1;
            }
        #endregion
        #region School
        int SchoolId = -1;
        try
        {
            SchoolId = int.Parse(Request.QueryString[Utility.Common.SchoolId]);
        }
        catch
        {
            SchoolId = -1;
        }
        if (SchoolId <= 0)
            try
            {
                SchoolId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId]);
            }
            catch
            {
                SchoolId = -1;
            }
        #endregion
        #endregion

        #region TeacherList
        int PageSize = 5;
        try
        {
            PageSize = Int16.Parse(Utility.Common.GetConfigValue("PageSize"));
        }
        catch
        {
        }
        var list = GetTeacher(SchoolId);
        pagingControl.PageSize = PageSize;
        pagingControl.RecordCount = list.Count;
        TeacherListRepeater.DataSource = list.Skip((pagingControl.PageIndex - 1) * pagingControl.PageSize).Take(pagingControl.PageSize);
        TeacherListRepeater.DataBind();
        #endregion

        #region SelectedTeacher
        if (TeacherId <= 0)
            return;
        var selectedTeachers = new BusinessLayer.School.SchoolTeachers().GetByProperty(typeof(int), "Id", TeacherId.ToString()).ToList();
        TeacherRepeater.DataSource = selectedTeachers;
        TeacherRepeater.DataBind();
        #endregion

        #region SEO
        try
        {
            Teacher selectedTeacher = selectedTeachers.FirstOrDefault();
            SetSeo(string.Format("{0} {1} {2}",selectedTeacher.Title, selectedTeacher.FirstName, selectedTeacher.LastName), string.Empty, string.Empty, selectedTeacher.Description);
            Page.Title = selectedTeacher.Title;
        }
        catch (Exception ex)
        {
        }
        #endregion
    }
    private List<Teacher> GetTeacher(int SchoolId)
    {
        if (SchoolId < 1)
        {
            var list = new BusinessLayer.School.SchoolTeachers().Get().AsEnumerable().Select(b => new { b.Id, Title = string.Format("{0} {1} {2}", b.Title, b.FirstName, b.LastName) });
            return list.ToList().Select(b => new Teacher { Id = b.Id, Title = b.Title }).ToList();
        }
        else
            return new BusinessLayer.School.SchoolTeachers().GetByProperty(typeof(int), "SchoolId", SchoolId.ToString()).ToList();
    }
}