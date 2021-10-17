using System.IO;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

public partial class Admin_Blog : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {

    }
    protected void BlogFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        BlogFormView.DataBind();
    }
    protected void BlogFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "CANCEL")
            //BlogFormView.ChangeMode(FormViewMode.Insert);
            BlogMultiView.SetActiveView(ShowView);
    }
    protected void BlogGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        BlogFormView.PageIndex = (BlogGridView.PageSize * BlogGridView.PageIndex) + BlogGridView.SelectedIndex;
        BlogMultiView.SetActiveView(EditView);
        BlogFormView.ChangeMode(FormViewMode.Edit);
        BlogGridView.DataBind();
        BlogGridView.SelectedIndex = -1;
    }
    protected void ClearImageButton_Click(object sender, EventArgs e)
    {
        TitleTextBox.Text = string.Empty;
        BlogFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton.OnClientClick = "return false;";
    }

    protected void SearchImageButton_Click(object sender, EventArgs e)
    {
        BlogGridView.PageSize = (PageSizeDropDownList.SelectedIndex == -1 || PageSizeDropDownList.SelectedValue == "0" ? 5 : Convert.ToInt32(PageSizeDropDownList.SelectedValue));
        if (TitleTextBox.Text != string.Empty)
        {
            BlogFormView.ChangeMode(FormViewMode.Insert);
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
        BlogMultiView.SetActiveView(EditView);
        BlogFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton_Click(sender, e);
        BlogFormView.DataBind();
    }
    protected void BlogEntityDataSource_Command(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangedEventArgs e)
    {
        BlogGridView.DataBind();
        //BlogFormView.ChangeMode(FormViewMode.Insert);
        BlogMultiView.SetActiveView(ShowView);
    }    
    protected void PageSizeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        BlogGridView.PageSize = int.Parse(PageSizeDropDownList.SelectedValue);
    }
    protected void BlogEntityDataSource_Commanding(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangingEventArgs e)
    {
        #region Profile
        ((Blog)e.Entity).ApplicantId = Profile.ApplicantId;
        #endregion
        #region File
        string picturePath = Utility.Common.GetConfigValue(Utility.Common.BlogImageUrl);
        string filePath = Utility.Common.GetConfigValue(Utility.Common.BlogFileUrl);

        ((Blog)e.Entity).Date = DateTime.Now;

        bool isChanged = true;
        if ((CheckBox)BlogFormView.FindControl("PictureCheckBox") != null)
            isChanged = ((CheckBox)BlogFormView.FindControl("PictureCheckBox")).Checked;


        if (isChanged)
        {
            FileUpload pictureFileUpload = (FileUpload)BlogFormView.FindControl("PictureFileUpload");
            if (pictureFileUpload.HasFile)
            {
                string imgpath = Server.MapPath(picturePath) + "\\" + ((Blog)e.Entity).SchoolId;

                if (!Directory.Exists(imgpath))
                    Directory.CreateDirectory(imgpath);

                string extension = Path.GetExtension(pictureFileUpload.PostedFile.FileName);
                string blogTitle = ((Blog)e.Entity).Title.Replace(" ","_");
                string schoolName = ((Blog)e.Entity).Information != null ? ((Blog)e.Entity).Information.Name.Replace(" ", "_") : string.Empty;
                string FileName = string.Format("{0}_{1}_عکس_دانستنی{2}", blogTitle,schoolName, extension);
                string imgFile = imgpath + "\\" + FileName;
                if (File.Exists(imgFile))
                    File.Delete(imgFile);
                pictureFileUpload.SaveAs(imgFile);
                ((Blog)e.Entity).ImageUrl = FileName;
            }
        }

        if ((CheckBox)BlogFormView.FindControl("FileCheckBox") != null)
            isChanged = ((CheckBox)BlogFormView.FindControl("FileCheckBox")).Checked;

        if (isChanged)
        {
            FileUpload fileFileUpload = (FileUpload)BlogFormView.FindControl("FileFileUpload");
            if (fileFileUpload.HasFile)
            {
                string imgpath = Server.MapPath(filePath) + "\\" + ((Blog)e.Entity).SchoolId;

                if (!Directory.Exists(imgpath))
                    Directory.CreateDirectory(imgpath);

                string extension = Path.GetExtension(fileFileUpload.PostedFile.FileName);
                string blogTitle = ((Blog)e.Entity).Title.Replace(" ", "_");
                string schoolName = ((Blog)e.Entity).Information != null ? ((Blog)e.Entity).Information.Name.Replace(" ", "_") : string.Empty;
                string FileName = string.Format("{0}_{1}_فایل_دانستنی{2}", blogTitle, schoolName, extension);
                string imgFile = imgpath + "\\" + FileName;
                if (File.Exists(imgFile))
                    File.Delete(imgFile);
                fileFileUpload.SaveAs(imgFile);
                ((Blog)e.Entity).FileUrl = FileName;
            }
        }
        #endregion
    }
}