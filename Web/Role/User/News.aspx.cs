using System.IO;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

public partial class Admin_News : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {

    }
    protected void NewsFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        NewsFormView.DataBind();
    }
    protected void NewsFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "CANCEL")
            //NewsFormView.ChangeMode(FormViewMode.Insert);
            NewsMultiView.SetActiveView(ShowView);
    }
    protected void NewsGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        NewsFormView.PageIndex = (NewsGridView.PageSize * NewsGridView.PageIndex) + NewsGridView.SelectedIndex;
        NewsMultiView.SetActiveView(EditView);
        NewsFormView.ChangeMode(FormViewMode.Edit);
        NewsGridView.DataBind();
        NewsGridView.SelectedIndex = -1;
    }
    protected void ClearImageButton_Click(object sender, EventArgs e)
    {
        TitleTextBox.Text = string.Empty;
        NewsFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton.OnClientClick = "return false;";
    }

    protected void SearchImageButton_Click(object sender, EventArgs e)
    {
        NewsGridView.PageSize = (PageSizeDropDownList.SelectedIndex == -1 || PageSizeDropDownList.SelectedValue == "0" ? 5 : Convert.ToInt32(PageSizeDropDownList.SelectedValue));
        if (TitleTextBox.Text != string.Empty)
        {
            NewsFormView.ChangeMode(FormViewMode.Insert);
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
        NewsMultiView.SetActiveView(EditView);
        NewsFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton_Click(sender, e);
        NewsFormView.DataBind();
    }
    protected void NewsEntityDataSource_Command(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangedEventArgs e)
    {
        NewsGridView.DataBind();
        //NewsFormView.ChangeMode(FormViewMode.Insert);
        NewsMultiView.SetActiveView(ShowView);
    }
    protected void PageSizeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        NewsGridView.PageSize = int.Parse(PageSizeDropDownList.SelectedValue);
    }
    protected void NewsEntityDataSource_Commanding(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangingEventArgs e)
    {
        #region Profile
        ((News)e.Entity).ApplicantId = Profile.ApplicantId;
        #endregion
        #region File
        string picturePath = Utility.Common.GetConfigValue(Utility.Common.NewsImageUrl);
        string filePath = Utility.Common.GetConfigValue(Utility.Common.NewsFileUrl);

        ((News)e.Entity).Date = DateTime.Now;
        bool isChanged = true;
        if ((CheckBox)NewsFormView.FindControl("PictureCheckBox") != null)
            isChanged = ((CheckBox)NewsFormView.FindControl("PictureCheckBox")).Checked;


        if (isChanged)
        {
            FileUpload pictureFileUpload = (FileUpload)NewsFormView.FindControl("PictureFileUpload");
            if (pictureFileUpload.HasFile)
            {
                string imgpath = Server.MapPath(picturePath) + "\\" + ((News)e.Entity).SchoolId;

                if (!Directory.Exists(imgpath))
                    Directory.CreateDirectory(imgpath);
                
                string extension = Path.GetExtension(pictureFileUpload.PostedFile.FileName);
                string newsTitle = ((News)e.Entity).Title.Replace(" ", "_");
                string schoolName = ((News)e.Entity).Information != null ? ((News)e.Entity).Information.Name.Replace(" ", "_") : string.Empty;
                string FileName = string.Format("{0}_{1}_عکس_خبر_{2}", newsTitle,schoolName, extension);
                string imgFile = imgpath + "\\" + FileName;

                if (File.Exists(imgFile))
                    File.Delete(imgFile);

                pictureFileUpload.SaveAs(imgFile);
                ((News)e.Entity).ImageUrl = FileName;
            }
        }

        if ((CheckBox)NewsFormView.FindControl("FileCheckBox") != null)
            isChanged = ((CheckBox)NewsFormView.FindControl("FileCheckBox")).Checked;

        if (isChanged)
        {
            FileUpload fileFileUpload = (FileUpload)NewsFormView.FindControl("FileFileUpload");
            if (fileFileUpload.HasFile)
            {
                string imgpath = Server.MapPath(filePath) + "\\" + ((News)e.Entity).SchoolId;

                if (!Directory.Exists(imgpath))
                    Directory.CreateDirectory(imgpath);

                string extension = Path.GetExtension(fileFileUpload.PostedFile.FileName);
                string newsTitle = ((News)e.Entity).Title.Replace(" ", "_");
                string schoolName = ((News)e.Entity).Information != null ? ((News)e.Entity).Information.Name.Replace(" ", "_") : string.Empty;
                string FileName = string.Format("{0}_{1}_فایل_خبر_{2}", newsTitle, schoolName, extension);
                string imgFile = imgpath + "\\" + FileName;

                if (File.Exists(imgFile))
                    File.Delete(imgFile);

                fileFileUpload.SaveAs(imgFile);
                ((News)e.Entity).FileUrl = FileName;
            }
        }
        #endregion
    }
}