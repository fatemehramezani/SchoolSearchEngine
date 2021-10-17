<%@ Page Title="پروفایل" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" CodeFile="Profile.aspx.cs" Inherits="Account_Profile" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <style>
        input[type="file"] {
            width: 190px;   
        }
    </style>
    <script language="javascript">
        function CheckChanged(isChecked) {
            var firstName = document.getElementById('FirstName');
            alert(firstName.text);
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
    اطلاعات کاربر
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="DescriptionContent" runat="Server">
    کاربر گرامی، در این قسمت می توانید اطلاعات پروفایل را ویرایش کنید.
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="vars_fields_section">
        <div class="rows">
            <div class="input_section">
                <br />
                <br />
                <br />
                <br />
                <label id="FirstName">نام </label>
                <asp:RequiredFieldValidator ID="FirstNameRequired" runat="server" ControlToValidate="FirstNameTextBox"
                    ErrorMessage="نام اجباری است" ToolTip="نام اجباری است"
                    ValidationGroup="ProfileValidationSummary" Display="Dynamic">*</asp:RequiredFieldValidator>
                <asp:TextBox runat="server" ID="FirstNameTextBox" MaxLength="50" />
            </div>
            <div class="input_section">
                <br />
                <br />
                <br />
                <br />
                <label id="LastName">نام خانوادگی </label>
                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="LastNameTextBox"
                    ErrorMessage="نام خانوادگی اجباری است" ToolTip="نام خانوادگی اجباری است"
                    ValidationGroup="ProfileValidationSummary" Display="Dynamic">*</asp:RequiredFieldValidator>
                <asp:TextBox runat="server" ID="LastNameTextBox" MaxLength="50" />
            </div>
            
        </div>
        <div class="rows">
            <div class="input_section">
                <label>تلفن همراه</label>
                <asp:TextBox runat="server" ID="MobileTextBox" MaxLength="10" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="MobileTextBox"
                    ErrorMessage="تلفن همراه اجباری است" ToolTip="تلفن همراه اجباری است"
                    ValidationGroup="ProfileValidationSummary" Display="Dynamic">*</asp:RequiredFieldValidator>
                <asp:RegularExpressionValidator ID="MobileRegularExpressionValidator" ValidationExpression="\d[10]" ValidationGroup="ProfileValidationSummary" runat="server" ControlToValidate="MobileTextBox" ErrorMessage="لطفا شماره موبایل را بدون صفر وارد نمایید"></asp:RegularExpressionValidator>
                
            </div>
            <div class="input_section">
                <label>تلفن</label>
                <asp:TextBox runat="server" ID="PhoneTextBox" MaxLength="10" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="PhoneTextBox"
                    ErrorMessage="تلفن اجباری است" ToolTip="تلفن اجباری است"
                    ValidationGroup="ProfileValidationSummary" Display="Dynamic">*</asp:RequiredFieldValidator>
                
            </div>
            </div>
      <div class="rows">
             <div class="input_section">
                <label>آدرس الکترونیکی</label>
                  <asp:TextBox runat="server" ID="EmailTextBox" MaxLength="100" />
                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="EmailTextBox"
                    ErrorMessage="آدرس الکترونیکی اجباری است" ToolTip="آدرس الکترونیکی اجباری است"
                    ValidationGroup="ProfileValidationSummary" Display="Dynamic">*</asp:RequiredFieldValidator>
               
            </div>
        </div>
       
    </div>
    <div class="vars_container">
        <asp:Button ID="ConfirmButton" runat="server" SkinID="MetroInsertModeButton" CausesValidation="False" OnClick="ConfirmButton_Click" Text="ویرایش" ValidationGroup="ProfileValidationSummary" />
    </div>
   
</asp:Content>

