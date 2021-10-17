using System.IO;
using System;
using System.Web.UI;
using System.Web.UI.WebControls;
using DataLayer;
namespace Role.Manager
{
    public partial class School : System.Web.UI.Page
    {
        protected void Page_Load(object sender, System.EventArgs e)
        {
        }
        protected void SchoolFormView_ItemDeleted(object sender, FormViewDeletedEventArgs e)
        {
            SchoolFormView.DataBind();
        }
        protected void SchoolFormView_ItemCommand(object sender, FormViewCommandEventArgs e)
        {
            if (e.CommandName.ToUpper() == "CANCEL")
                SchoolMultiView.SetActiveView(ShowView);
        }
        protected void SchoolGridView_SelectedIndexChanged(object sender, EventArgs e)
        {
            SchoolFormView.PageIndex = (SchoolGridView.PageSize * SchoolGridView.PageIndex) + SchoolGridView.SelectedIndex;
            SchoolMultiView.SetActiveView(EditView);
            SchoolFormView.ChangeMode(FormViewMode.Edit);
            SchoolGridView.DataBind();
            SchoolGridView.SelectedIndex = -1;
        }
        protected void ClearImageButton_Click(object sender, EventArgs e)
        {
            NameTextBox.Text = string.Empty;
            SchoolFormView.ChangeMode(FormViewMode.Insert);
            ClearImageButton.OnClientClick = "return false;";
        }

        protected void SearchImageButton_Click(object sender, EventArgs e)
        {
            SchoolGridView.PageSize = (PageSizeDropDownList.SelectedIndex == -1 || PageSizeDropDownList.SelectedValue == "0" ? 5 : Convert.ToInt32(PageSizeDropDownList.SelectedValue));
            if (NameTextBox.Text != string.Empty)
            {
                SchoolFormView.ChangeMode(FormViewMode.Insert);
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
            SchoolMultiView.SetActiveView(EditView);
            SchoolFormView.ChangeMode(FormViewMode.Insert);
            ClearImageButton_Click(sender, e);
            SchoolFormView.DataBind();
        }
        protected void SchoolEntityDataSource_Command(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangedEventArgs e)
        {
            SchoolGridView.DataBind();
            //SchoolFormView.ChangeMode(FormViewMode.Insert);
            SchoolMultiView.SetActiveView(ShowView);
        }
        protected void PageSizeDropDownList_SelectedIndexChanged(object sender, EventArgs e)
        {
            SchoolGridView.PageSize = int.Parse(PageSizeDropDownList.SelectedValue);
        }
        protected void SchoolEntityDataSource_Commanding(object sender, Microsoft.AspNet.EntityDataSource.EntityDataSourceChangingEventArgs e)
        {
            #region Profile
            //((Information)e.Entity).ApplicantId = Profile.ApplicantId;
            ((Information)e.Entity).LastUpdate = DateTime.Now;
            #endregion
         
            #region File
            string picturePath = "~/Files/School/Logos";
            string filePath = "~/Files/School/Banners";

            bool isChanged = true;
            if ((CheckBox)SchoolFormView.FindControl("PictureCheckBox") != null)
                isChanged = ((CheckBox)SchoolFormView.FindControl("PictureCheckBox")).Checked;

            if (isChanged)
            {
                FileUpload pictureFileUpload = (FileUpload)SchoolFormView.FindControl("PictureFileUpload");
                if (pictureFileUpload.HasFile)
                {
                    string imgpath = Server.MapPath(picturePath) + "\\";// + User.Identity.GetUserId();// + Profile.ApplicantId;User.GetUserId();
                    if (!Directory.Exists(imgpath))
                        Directory.CreateDirectory(imgpath);
                    string extension = Path.GetExtension(pictureFileUpload.PostedFile.FileName);
                    string FileName = string.Format("{0}_{1}_عکس_مدرسه_{2}", ((Information)e.Entity).Name.Replace(" ", "_"), User.Identity.Name,extension);//Profile.ApplicantId,extension);
                    string imgFile = imgpath + "\\" + FileName;
                    if (File.Exists(imgFile))
                        File.Delete(imgFile);
                    pictureFileUpload.SaveAs(imgFile);
                    ((Information)e.Entity).LogoURL = FileName;
                }
            }

            if ((CheckBox)SchoolFormView.FindControl("BannerCheckBox") != null)
                isChanged = ((CheckBox)SchoolFormView.FindControl("BannerCheckBox")).Checked;

            if (isChanged)
            {
                FileUpload fileFileUpload = (FileUpload)SchoolFormView.FindControl("BannerFileUpload");
                if (fileFileUpload.HasFile)
                {
                    string imgpath = Server.MapPath(filePath) + "\\";// + HttpContext.Current.Profile.ApplicantId;

                    if (!Directory.Exists(imgpath))
                        Directory.CreateDirectory(imgpath);

                    string extension = Path.GetExtension(fileFileUpload.PostedFile.FileName);
                    string FileName = string.Format("{0}_{1}_بنر_مدرسه_{2}", ((Information)e.Entity).Name.Replace(" ", "_"), User.Identity.Name, extension);//Profile.ApplicantId, extension);
                    string imgFile = imgpath + "\\" + FileName;
                    if (File.Exists(imgFile))
                        File.Delete(imgFile);
                    fileFileUpload.SaveAs(imgFile);
                    ((Information)e.Entity).BannerURL = FileName;
                }
            }
            #endregion
        }
    }
}