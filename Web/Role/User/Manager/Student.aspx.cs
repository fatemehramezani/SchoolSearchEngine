using System.IO;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

public partial class Admin_Student : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {

    }
    protected void StudentFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        StudentFormView.DataBind();
    }
    protected void StudentFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "CANCEL")
            //StudentFormView.ChangeMode(FormViewMode.Insert);
            StudentMultiView.SetActiveView(ShowView);
    }
    protected void StudentGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        StudentFormView.PageIndex = (StudentGridView.PageSize * StudentGridView.PageIndex) + StudentGridView.SelectedIndex;
        StudentMultiView.SetActiveView(EditView);
        StudentFormView.ChangeMode(FormViewMode.Edit);
        StudentGridView.DataBind();
        StudentGridView.SelectedIndex = -1;
    }
    protected void ClearImageButton_Click(object sender, EventArgs e)
    {
        TitleTextBox.Text = string.Empty;
        StudentFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton.OnClientClick = "return false;";
    }

    protected void SearchImageButton_Click(object sender, EventArgs e)
    {
        StudentGridView.PageSize = (PageSizeDropDownList.SelectedIndex == -1 || PageSizeDropDownList.SelectedValue == "0" ? 5 : Convert.ToInt32(PageSizeDropDownList.SelectedValue));
        if (TitleTextBox.Text != string.Empty)
        {
            StudentFormView.ChangeMode(FormViewMode.Insert);
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
        StudentMultiView.SetActiveView(EditView);
        StudentFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton_Click(sender, e);
        StudentFormView.DataBind();
    }
    protected void StudentEntityDataSource_Command(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangedEventArgs e)
    {
        StudentGridView.DataBind();
        //StudentFormView.ChangeMode(FormViewMode.Insert);
        StudentMultiView.SetActiveView(ShowView);
    }
    protected void PageSizeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        StudentGridView.PageSize = int.Parse(PageSizeDropDownList.SelectedValue);
    }
    protected void StudentEntityDataSource_Commanding(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangingEventArgs e)
    {
        #region Profile
        ((Student)e.Entity).ApplicantId = Profile.ApplicantId;
        #endregion

        #region File
        string avatarPath = Utility.Common.GetConfigValue(Utility.Common.StudentAvatarUrl);

        bool isChanged = true;
        if ((CheckBox)StudentFormView.FindControl("AvatarCheckBox") != null)
            isChanged = ((CheckBox)StudentFormView.FindControl("AvatarCheckBox")).Checked;


        if (isChanged)
        {
            FileUpload avatarFileUpload = (FileUpload)StudentFormView.FindControl("AvatarFileUpload");
            if (avatarFileUpload.HasFile)
            {
                string imgpath = Server.MapPath(avatarPath) + "\\" + ((Student)e.Entity).SchoolId;

                if (!Directory.Exists(imgpath))
                    Directory.CreateDirectory(imgpath);
                
                string extension = Path.GetExtension(avatarFileUpload.PostedFile.FileName);
                string studentTitle = string.Format("{0} {1} {2}",((Student)e.Entity).Title.Replace(" ", "_"),((Student)e.Entity).FirstName.Replace(" ", "_"),((Student)e.Entity).LastName.Replace(" ", "_"));
                string schoolName = ((Student)e.Entity).Information != null ? ((Student)e.Entity).Information.Name.Replace(" ", "_") : string.Empty;
                string FileName = string.Format("{0}_{1}_عکس_دانش_آموز_{2}", studentTitle,schoolName, extension);
                string imgFile = imgpath + "\\" + FileName;

                if (File.Exists(imgFile))
                    File.Delete(imgFile);

                avatarFileUpload.SaveAs(imgFile);
                ((Student)e.Entity).AvatarUrl = FileName;
            }
        }       
        #endregion
    }
}