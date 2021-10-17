using DataLayer;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Admin_PhotoCategory : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {

    }
    protected void PhotoCategoryFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        PhotoCategoryFormView.DataBind();
    }
    protected void PhotoCategoryFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "CANCEL")
            //PhotoCategoryFormView.ChangeMode(FormViewMode.Insert);
            PhotoCategoryMultiView.SetActiveView(ShowView);
    }
    protected void PhotoCategoryGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        PhotoCategoryFormView.PageIndex = (PhotoCategoryGridView.PageSize * PhotoCategoryGridView.PageIndex) + PhotoCategoryGridView.SelectedIndex;
        PhotoCategoryMultiView.SetActiveView(EditView);
        PhotoCategoryFormView.ChangeMode(FormViewMode.Edit);
        PhotoCategoryGridView.DataBind();
        PhotoCategoryGridView.SelectedIndex = -1;
    }
    protected void ClearImageButton_Click(object sender, EventArgs e)
    {
        TitleTextBox.Text = string.Empty;
        PhotoCategoryFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton.OnClientClick = "return false;";
    }

    protected void SearchImageButton_Click(object sender, EventArgs e)
    {
        PhotoCategoryGridView.PageSize = (PageSizeDropDownList.SelectedIndex == -1 || PageSizeDropDownList.SelectedValue == "0" ? 5 : Convert.ToInt32(PageSizeDropDownList.SelectedValue));
        if (TitleTextBox.Text != string.Empty)
        {
            PhotoCategoryFormView.ChangeMode(FormViewMode.Insert);
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
        PhotoCategoryMultiView.SetActiveView(EditView);
        PhotoCategoryFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton_Click(sender, e);
        PhotoCategoryFormView.DataBind();
    }
    protected void PhotoCategoryEntityDataSource_Command(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangedEventArgs e)
    {
        PhotoCategoryGridView.DataBind();
        //PhotoCategoryFormView.ChangeMode(FormViewMode.Insert);
        PhotoCategoryMultiView.SetActiveView(ShowView);
    }
    protected void PageSizeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        PhotoCategoryGridView.PageSize = int.Parse(PageSizeDropDownList.SelectedValue);
    }
    protected void PhotoCategoryEntityDataSource_Commanding(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangingEventArgs e)
    {
        #region Profile
        //((PhotoCategory)e.Entity).ApplicantId = Profile.ApplicantId;
        #endregion
    }
    protected void PhotoCategoryFilesImageButton_Click(object sender, ImageClickEventArgs e)
    {
        string photoCategoryId = ((System.Web.UI.WebControls.Image)(sender)).AlternateText;
        if (!string.IsNullOrEmpty(photoCategoryId))
        {
            var list = new BusinessLayer.Common.PhotoCategories().GetByProperty(typeof(int), "Id", photoCategoryId);
            string photoCategoryTitle = string.Empty;
            if (list != null && list.Count() > 0)
                photoCategoryTitle = list.FirstOrDefault().Title;
            Response.Redirect(string.Format("‍Photo.aspx?Id={0}&Title={1}", photoCategoryId, photoCategoryTitle));
        }
    }
    
}