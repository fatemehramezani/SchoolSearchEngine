<%@ Page Title="تغییر رمز" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true"
    CodeFile="ChangePassword.aspx.cs" Inherits="Account_ChangePassword" Culture="auto" UICulture="auto" %>

<asp:Content ID="HeaderContent" runat="server" ContentPlaceHolderID="HeadContent">
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="DescriptionContent" runat="Server">
    با استفاده از فرم زیر می توانید کلمه ی عبور خود را تغییر دهید. همواره سعی کنید کلمه عبور خود 
را در ذهنتان ذخیره کرده و هیچ گاه آن را در اختیار دیگران قرار ندهید.
    کلمه عبور جدید باید حداقل  <%= Membership.MinRequiredPasswordLength %>کاراکتر باشد.
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
    تغییر کلمه عبور
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:ChangePassword ID="ChangePassword1" runat="server" SuccessPageUrl="ChangePasswordSuccess.aspx">
        <ChangePasswordTemplate>
            <div class="vars_fields_section">
                <div class="rows">
                    <div class="input_section">
                        <label>کلمه عبور قدیمی</label>
                        <asp:TextBox ID="CurrentPassword" class="field" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="CurrentPasswordRequired" runat="server" ControlToValidate="CurrentPassword"
                            ErrorMessage="کلمه عبور قدیمی اجباری است" ToolTip="کلمه عبور قدیمی اجباری است" ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="input_section">
                        <label>کلمه عبور جدید</label>

                        <asp:TextBox ID="NewPassword" class="field" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="NewPasswordRequired" runat="server" ControlToValidate="NewPassword"
                            ErrorMessage="کلمه عبور جدید اجباری است" ToolTip="کلمه عبور جدید اجباری است"
                            ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>
                    </div>
                    <div class="input_section" style="margin: 0px !important;">
                        <label>تکرار کلمه عبور</label>
                        <asp:TextBox ID="ConfirmNewPassword" runat="server" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="ConfirmNewPasswordRequired" runat="server" ControlToValidate="ConfirmNewPassword"
                            ErrorMessage="تکرار کلمه عبور اجباری است" ToolTip="تکرار کلمه عبور اجباری است"
                            ValidationGroup="ChangePassword1">*</asp:RequiredFieldValidator>

                        <asp:CompareValidator ID="NewPasswordCompare" runat="server" ControlToCompare="NewPassword" ControlToValidate="ConfirmNewPassword"
                            Display="Dynamic" ErrorMessage="کلمه عبور جدید و تکرار آن باید مطابقت داشته باشند."
                            ValidationGroup="ChangePassword1"></asp:CompareValidator>
                        <div class="rows"><a href="#">بازیابی کلمه عبور</a></div>
                    </div>
                    <div class="vars_container">
                        <asp:Button ID="ChangePasswordPushButton" runat="server" CommandName="ChangePassword" Text="تغییر رمز" ValidationGroup="ChangePassword1" SkinID="MetroInsertModeButton" />
                        <asp:Button ID="CancelPushButton" runat="server" CausesValidation="False" CommandName="Cancel" Text="انصراف" SkinID="MetroInsertModeButton" />

                        <br />
                        <asp:Literal ID="FailureText" runat="server" Text="کلمه عبور تغییر نکرد. لطفا دوباره تلاش کنید.کلمه عبور جدید باید حداقل 6 کاراکتر باشد." EnableViewState="False" Visible="False"></asp:Literal>

                        <div dir="rtl">
                            <asp:ValidationSummary ID="LoginUserValidationSummary" runat="server" ValidationGroup="ChangeUserPasswordValidationGroup" />
                        </div>
                    </div>
        </ChangePasswordTemplate>
    </asp:ChangePassword>
         
</asp:Content>
