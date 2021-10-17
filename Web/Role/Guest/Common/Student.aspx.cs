using DataLayer;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.UI.HtmlControls;

public partial class Guest_Student : BasePage
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
            SetStudent();
    }

    private void SetStudent()
    {
        #region Parameters
        #region Student
        int StudentId = -1;
        try
        {
            StudentId = int.Parse(Request.QueryString[Utility.Common.StudentId]);
        }
        catch
        {
            StudentId = -1;
        }
        if (StudentId <= 0)
            try
            {
                StudentId = Convert.ToInt32(HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.StudentId]);
            }
            catch
            {
                StudentId = -1;
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

        #region StudentList
        int PageSize = 5;
        try
        {
            PageSize = Int16.Parse(Utility.Common.GetConfigValue("PageSize"));
        }
        catch
        {
        }
        var list = GetStudent(SchoolId);
        pagingControl.PageSize = PageSize;
        pagingControl.RecordCount = list.Count;
        StudentListRepeater.DataSource = list.Skip((pagingControl.PageIndex - 1) * pagingControl.PageSize).Take(pagingControl.PageSize);
        StudentListRepeater.DataBind();
        #endregion

        #region SelectedStudent
        if (StudentId <= 0)
            return;
        var selectedStudents = new BusinessLayer.School.SchoolStudents().GetByProperty(typeof(int), "Id", StudentId.ToString()).ToList();
        StudentRepeater.DataSource = selectedStudents;
        StudentRepeater.DataBind();
        #endregion

        #region SEO
        try
        {
            Student selectedStudent = selectedStudents.FirstOrDefault();
            SetSeo(string.Format("{0} {1} {2}",selectedStudent.Title, selectedStudent.FirstName, selectedStudent.LastName), string.Empty, string.Empty, selectedStudent.Description);
            Page.Title = selectedStudent.Title;
        }
        catch (Exception ex)
        {
        }
        #endregion
    }
    private List<Student> GetStudent(int SchoolId)
    {
        if (SchoolId < 1)
        {
            var list = new BusinessLayer.School.SchoolStudents().Get().AsEnumerable().Select(b => new { b.Id, Title = string.Format("{0} {1} {2}", b.Title, b.FirstName, b.LastName) });
            return list.ToList().Select(b => new Student { Id = b.Id, Title = b.Title }).ToList();
        }
        else
            return new BusinessLayer.School.SchoolStudents().GetByProperty(typeof(int), "SchoolId", SchoolId.ToString()).ToList();
    }
}