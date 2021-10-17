using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data.Objects;

public partial class Admin_User : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        
    }
    protected void UserFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
    {
        UserFormView.DataBind();
    }
    protected void UserFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
    {
        if (e.CommandName.ToUpper() == "CANCEL")
        {
            UserMultiView.SetActiveView(ShowView);
            UserFormView.ChangeMode(FormViewMode.Insert);
        }
    }
    protected void UserGridView_SelectedIndexChanged(object sender, EventArgs e)
    {
        UserFormView.PageIndex = (UserGridView.PageSize * UserGridView.PageIndex) + UserGridView.SelectedIndex;        
        UserFormView.ChangeMode(FormViewMode.Edit);
        UserMultiView.SetActiveView(EditView);        
        UserGridView.DataBind();
        UserGridView.SelectedIndex = -1;
    }
    protected void ClearImageButton_Click(object sender, EventArgs e)
    {
        FirstNameTextBox.Text = LastNameTextBox.Text = UserNameTextBox.Text =string.Empty;
        UserFormView.Visible = false;
        ClearImageButton.OnClientClick = "return false;";
    }
    protected void SearchImageButton_Click(object sender, EventArgs e)
    {
        UserGridView.PageSize = (PageSizeDropDownList.SelectedIndex == -1 || PageSizeDropDownList.SelectedValue == "0" ? 5 : Convert.ToInt32(PageSizeDropDownList.SelectedValue));
        if (FirstNameTextBox.Text != string.Empty ||
            LastNameTextBox.Text != string.Empty||
            UserNameTextBox.Text != string.Empty)
        {
            UserFormView.ChangeMode(FormViewMode.Insert);
            ClearImageButton.OnClientClick = string.Empty;
        }
        else
            ClearImageButton_Click(sender, e);
    }
    protected void NewImageButton_Click(object sender, ImageClickEventArgs e)
    {
        UserMultiView.SetActiveView(EditView);
        UserFormView.ChangeMode(FormViewMode.Insert);
        ClearImageButton_Click(sender, e);
        UserFormView.DataBind();        
    }
    protected void UserEntityDataSource_Command(object sender, EntityDataSourceChangedEventArgs e)
    {
        UserGridView.DataBind();
        UserFormView.ChangeMode(FormViewMode.Insert);
        UserMultiView.SetActiveView(ShowView);
    }
    protected void PageSizeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
    {
        UserGridView.PageSize = int.Parse(PageSizeDropDownList.SelectedValue);
    }
}


