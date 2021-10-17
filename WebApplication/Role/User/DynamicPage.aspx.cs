using System.IO;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;

public partial class Admin_DynamicPage : System.Web.UI.Page
{
    protected void Page_Load(object sender, System.EventArgs e)
    {

    }
    protected void DynamicPageFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        DynamicPageFormView.DataBind();
    }
    protected void DynamicPageFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "CANCEL")
            //DynamicPageFormView.ChangeMode(FormViewMode.Insert);
            DynamicPageMultiView.SetActiveView(ShowView);
    }
    protected void DynamicPageGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        DynamicPageFormView.PageIndex = (DynamicPageGridView.PageSize * DynamicPageGridView.PageIndex) + DynamicPageGridView.SelectedIndex;
        DynamicPageMultiView.SetActiveView(EditView);
        DynamicPageFormView.ChangeMode(FormViewMode.Edit);
        DynamicPageGridView.DataBind();
        DynamicPageGridView.SelectedIndex = -1;
    }
    protected void ClearImageButton_Click(object sender, EventArgs e)
    {
        TitleTextBox.Text = string.Empty;
        DynamicPageFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton.OnClientClick = "return false;";
    }

    protected void SearchImageButton_Click(object sender, EventArgs e)
    {
        DynamicPageGridView.PageSize = (PageSizeDropDownList.SelectedIndex == -1 || PageSizeDropDownList.SelectedValue == "0" ? 5 : Convert.ToInt32(PageSizeDropDownList.SelectedValue));
        if (TitleTextBox.Text != string.Empty)
        {
            DynamicPageFormView.ChangeMode(FormViewMode.Insert);
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
        DynamicPageMultiView.SetActiveView(EditView);
        DynamicPageFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton_Click(sender, e);
        DynamicPageFormView.DataBind();
    }
    protected void DynamicPageEntityDataSource_Command(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangedEventArgs e)
    {
        DynamicPageGridView.DataBind();
        //DynamicPageFormView.ChangeMode(FormViewMode.Insert);
        DynamicPageMultiView.SetActiveView(ShowView);
    }
    protected void PageSizeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        DynamicPageGridView.PageSize = int.Parse(PageSizeDropDownList.SelectedValue);
    }
}