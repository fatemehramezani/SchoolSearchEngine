using System.IO;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

public partial class Admin_Work : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {

    }
    protected void WorkFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        WorkFormView.DataBind();
    }
    protected void WorkFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "CANCEL")
            //WorkFormView.ChangeMode(FormViewMode.Insert);
            WorkMultiView.SetActiveView(ShowView);
    }
    protected void WorkGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        WorkFormView.PageIndex = (WorkGridView.PageSize * WorkGridView.PageIndex) + WorkGridView.SelectedIndex;
        WorkMultiView.SetActiveView(EditView);
        WorkFormView.ChangeMode(FormViewMode.Edit);
        WorkGridView.DataBind();
        WorkGridView.SelectedIndex = -1;
    }
    protected void ClearImageButton_Click(object sender, EventArgs e)
    {
        TitleTextBox.Text = string.Empty;
        WorkFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton.OnClientClick = "return false;";
    }

    protected void SearchImageButton_Click(object sender, EventArgs e)
    {
        WorkGridView.PageSize = (PageSizeDropDownList.SelectedIndex == -1 || PageSizeDropDownList.SelectedValue == "0" ? 5 : Convert.ToInt32(PageSizeDropDownList.SelectedValue));
        if (TitleTextBox.Text != string.Empty)
        {
            WorkFormView.ChangeMode(FormViewMode.Insert);
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
        WorkMultiView.SetActiveView(EditView);
        WorkFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton_Click(sender, e);
        WorkFormView.DataBind();
    }
    protected void WorkEntityDataSource_Command(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangedEventArgs e)
    {
        WorkGridView.DataBind();
        //WorkFormView.ChangeMode(FormViewMode.Insert);
        WorkMultiView.SetActiveView(ShowView);
    }
    protected void PageSizeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        WorkGridView.PageSize = int.Parse(PageSizeDropDownList.SelectedValue);
    }
    protected void WorkEntityDataSource_InsertingFiles(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangingEventArgs e)
    {
        string picturePath = "~/Files/Work/Images";

        bool isChanged = true;
        if ((CheckBox)WorkFormView.FindControl("PictureCheckBox") != null)
            isChanged = ((CheckBox)WorkFormView.FindControl("PictureCheckBox")).Checked;


        if (isChanged)
        {
            FileUpload pictureFileUpload = (FileUpload)WorkFormView.FindControl("PictureFileUpload");
            if (pictureFileUpload.HasFile)
            {
                string imgpath = Server.MapPath(picturePath);
                if (!Directory.Exists(imgpath))
                    Directory.CreateDirectory(imgpath);

                string imgFile = imgpath + "\\" + pictureFileUpload.FileName;
                pictureFileUpload.SaveAs(imgFile);
                ((Work)e.Entity).Image = pictureFileUpload.FileName;
            }
        }
    }
}