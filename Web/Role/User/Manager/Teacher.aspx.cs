using System.IO;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

public partial class Admin_Teacher : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {

    }
    protected void TeacherFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        TeacherFormView.DataBind();
    }
    protected void TeacherFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "CANCEL")
            //TeacherFormView.ChangeMode(FormViewMode.Insert);
            TeacherMultiView.SetActiveView(ShowView);
    }
    protected void TeacherGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        TeacherFormView.PageIndex = (TeacherGridView.PageSize * TeacherGridView.PageIndex) + TeacherGridView.SelectedIndex;
        TeacherMultiView.SetActiveView(EditView);
        TeacherFormView.ChangeMode(FormViewMode.Edit);
        TeacherGridView.DataBind();
        TeacherGridView.SelectedIndex = -1;
    }
    protected void ClearImageButton_Click(object sender, EventArgs e)
    {
        TitleTextBox.Text = string.Empty;
        TeacherFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton.OnClientClick = "return false;";
    }

    protected void SearchImageButton_Click(object sender, EventArgs e)
    {
        TeacherGridView.PageSize = (PageSizeDropDownList.SelectedIndex == -1 || PageSizeDropDownList.SelectedValue == "0" ? 5 : Convert.ToInt32(PageSizeDropDownList.SelectedValue));
        if (TitleTextBox.Text != string.Empty)
        {
            TeacherFormView.ChangeMode(FormViewMode.Insert);
            ClearImageButton.OnClientClick = string.Empty;
        }
        else
            ClearImageButton_Click(sender, e);
    }
    protected void SearchImageButton_Click(object sender, ImageClickEventArgs e)
    {

    }
    protected void NewImageButton_Click(object sender, ImageClickEventArgs e)
    {
        TeacherMultiView.SetActiveView(EditView);
        TeacherFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton_Click(sender, e);
        TeacherFormView.DataBind();
    }
    protected void TeacherEntityDataSource_Command(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangedEventArgs e)
    {
        TeacherGridView.DataBind();
        //TeacherFormView.ChangeMode(FormViewMode.Insert);
        TeacherMultiView.SetActiveView(ShowView);
    }
    protected void PageSizeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        TeacherGridView.PageSize = int.Parse(PageSizeDropDownList.SelectedValue);
    }
    protected void TeacherEntityDataSource_Commanding(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangingEventArgs e)
    {
        #region Profile
        ((Teacher)e.Entity).ApplicantId = Profile.ApplicantId;
        #endregion
        #region File
        string avatarPath = Utility.Common.GetConfigValue(Utility.Common.TeacherAvatarUrl);
        string resumePath = Utility.Common.GetConfigValue(Utility.Common.TeacherResumeUrl);

        bool isChanged = true;
        if ((CheckBox)TeacherFormView.FindControl("AvatarCheckBox") != null)
            isChanged = ((CheckBox)TeacherFormView.FindControl("AvatarCheckBox")).Checked;


        if (isChanged)
        {
            FileUpload avatarFileUpload = (FileUpload)TeacherFormView.FindControl("AvatarFileUpload");
            if (avatarFileUpload.HasFile)
            {
                string imgpath = Server.MapPath(avatarPath) + "\\" + ((Teacher)e.Entity).SchoolId;

                if (!Directory.Exists(imgpath))
                    Directory.CreateDirectory(imgpath);
                
                string extension = Path.GetExtension(avatarFileUpload.PostedFile.FileName);
                string teacherTitle = string.Format("{0} {1} {2}",((Teacher)e.Entity).Title.Replace(" ", "_"),((Teacher)e.Entity).FirstName.Replace(" ", "_"),((Teacher)e.Entity).LastName.Replace(" ", "_"));
                string schoolName = ((Teacher)e.Entity).Information != null ? ((Teacher)e.Entity).Information.Name.Replace(" ", "_") : string.Empty;
                string FileName = string.Format("{0}_{1}_عکس_معلم_{2}", teacherTitle,schoolName, extension);
                string imgFile = imgpath + "\\" + FileName;

                if (File.Exists(imgFile))
                    File.Delete(imgFile);

                avatarFileUpload.SaveAs(imgFile);
                ((Teacher)e.Entity).AvatarUrl = FileName;
            }
        }

        if ((CheckBox)TeacherFormView.FindControl("ResumeCheckBox") != null)
            isChanged = ((CheckBox)TeacherFormView.FindControl("ResumeCheckBox")).Checked;

        if (isChanged)
        {
            FileUpload resumeFileUpload = (FileUpload)TeacherFormView.FindControl("ResumeFileUpload");
            if (resumeFileUpload.HasFile)
            {
                string imgpath = Server.MapPath(resumePath) + "\\" + ((Teacher)e.Entity).SchoolId;

                if (!Directory.Exists(imgpath))
                    Directory.CreateDirectory(imgpath);

                string extension = Path.GetExtension(resumeFileUpload.PostedFile.FileName);
                string teacherTitle = string.Format("{0} {1} {2}", ((Teacher)e.Entity).Title.Replace(" ", "_"), ((Teacher)e.Entity).FirstName.Replace(" ", "_"), ((Teacher)e.Entity).LastName.Replace(" ", "_"));
                string schoolName = ((Teacher)e.Entity).Information != null ? ((Teacher)e.Entity).Information.Name.Replace(" ", "_") : string.Empty;
                string FileName = string.Format("{0}_{1}_رزومه_معلم_{2}", teacherTitle, schoolName, extension);
                string imgFile = imgpath + "\\" + FileName;

                if (File.Exists(imgFile))
                    File.Delete(imgFile);

                resumeFileUpload.SaveAs(imgFile);
                ((Teacher)e.Entity).ResumeUrl = FileName;
            }
        }
        #endregion
    }
}