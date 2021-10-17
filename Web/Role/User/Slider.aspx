<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master"    AutoEventWireup="true" CodeFile="Slider.aspx.cs" Inherits="Admin_Slider" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link href="../App_Themes/Default/css/TableStyles.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript">
        function ValidateFileUpload(Source, args) {
            var fuData = document.getElementById('<%= MaxPicFileUpload.ClientID %>');
            var FileUploadPath = fuData.value;

            if (FileUploadPath == '') {
                // There is no file selected
                args.IsValid = false;
            }
            else {
                var Extension = FileUploadPath.substring(FileUploadPath.lastIndexOf('.') + 1).toLowerCase();

                if (Extension == "jpg" || Extension == "jpeg" || Extension == "png") {
                    args.IsValid = true; // Valid file type
                }
                else {
                    args.IsValid = false; // Not valid file type
                }
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TitleContent" runat="Server">
    اسلایدر 
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="DescriptionContent" runat="Server">
    از طریق این صفحه می توانید تصاویر مربوط به اسلایدر صفحه اصلی  را مدیریت نمایید. 
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div style="padding: 20px;">
        <h3>ایجاد تصویر جدید</h3>
        <asp:FileUpload ID="MaxPicFileUpload" runat="server" Width="95%" />
        <asp:RequiredFieldValidator ID="MaxRequiredFieldValidator" runat="server" ErrorMessage="*"
            ControlToValidate="MaxPicFileUpload"></asp:RequiredFieldValidator>
        <asp:CustomValidator ID="MaxFileCustomValidator" runat="server" ControlToValidate="MaxPicFileUpload"
            ErrorMessage="اندازه تصویر باید کوچکتر از 400 کیلو بایت باشد" OnServerValidate="MaxFileCustomValidator_ServerValidate" SetFocusOnError="True"></asp:CustomValidator>
        <asp:CustomValidator ID="TypeCustomValidator" runat="server" ControlToValidate="MaxPicFileUpload"
            ErrorMessage="باید تصویر انتخاب شود" ClientValidationFunction="ValidateFileUpload"></asp:CustomValidator>
        <asp:Button ID="InsertButton" runat="server" CommandName="Insert" Text="ایجاد" OnClick="InsertButton_Click" />
    </div>
    <div>
        <h3>مدیریت تصاویر اسلایدر</h3>
        <asp:MultiView ID="ImageMultiView" runat="server">
            <asp:View ID="NoFileView" runat="server">
                <p>
                    تصویری در مسیر فایل های اسلایدر وجود ندارد
                </p>
            </asp:View>
            <asp:View ID="FileView" runat="server">
                <div style="overflow: auto; width: 600px; border: 1px gray solid; padding: 10px; margin: 0px auto;">
                    <asp:Table ID="ImageTable" runat="server">
                    </asp:Table>
                </div>
            </asp:View>
        </asp:MultiView>
    </div>
</asp:Content>
