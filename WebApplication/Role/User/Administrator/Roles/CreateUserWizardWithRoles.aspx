<%@ Page Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" Inherits="Admin_Roles_CreateUserWizardWithRoles" Title="ایجاد کاربر" Codebehind="CreateUserWizardWithRoles.aspx.cs" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
    ایجاد کاربر
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="DescriptionContent" runat="Server">
    کاربر گرامی، در این قسمت می توانید کاربر جدید ایجاد کنید.
</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="Server">
    <h5>کلمه عبور باید حداقل  <%= Membership.MinRequiredPasswordLength %> کاراکتر باشد.
    </h5>
    <asp:CreateUserWizard ID="RegisterUserWithRoles" runat="server"
        ContinueDestinationPageUrl="~/Role/Administrator/Default.aspx"
        OnActiveStepChanged="RegisterUserWithAdmin_Roles_ActiveStepChanged"
        LoginCreatedUser="False"
        DuplicateEmailErrorMessage="آدرس الکترونیکی تکراری می باشد"
        DuplicateUserNameErrorMessage="نام کاربری تکراری می باشد"
        PasswordRequiredErrorMessage="کلمه عبور اجباری است"
        PasswordRegularExpressionErrorMessage="کلمه عبور باید حداقل 6 کرکتر باشد"
        StepNextButtonText="بعدی" StepNextButtonStyle-CssClass="insert_mode_btn"
        StartNextButtonText="بعدی" StartNextButtonStyle-CssClass="insert_mode_btn"
        StepPreviousButtonText="قبلی" StepPreviousButtonStyle-CssClass="insert_mode_btn">
        <WizardSteps>
            <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                <ContentTemplate>
                    <div class="vars_fields_section">
                        <div class="rows">
                            <div class="input_section">
                                <label>نام کاربری</label>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                    Display="Dynamic" ErrorMessage="نام کاربری اجباری است" ToolTip="نام کاربری اجباری است"
                                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                <asp:TextBox runat="server" Style="background-image: url(../App_Themes/Default/images/user_suit.png); background-repeat: no-repeat; background-position: 5px;" name="textfield" ID="UserName" />
                            </div>
                            <div class="input_section">
                                <label>آدرس الکترونیکی</label>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                    Display="Dynamic" ErrorMessage="آدرس الکترونیکی اجباری است." ToolTip="آدرس الکترونیکی اجباری است"
                                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                <asp:TextBox runat="server" Style="background-image: url(../App_Themes/Default/images/email.png); background-repeat: no-repeat; background-position: 5px;" name="textfield" ID="Email" />
                            </div>
                        </div>
                        <div class="rows">
                            <div class="input_section">
                                <label>کلمه عبور</label>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                    Display="Dynamic" ErrorMessage="کلمه عبور اجباری است" ToolTip="کلمه عبور اجباری است"
                                    ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                <asp:TextBox runat="server" TextMode="Password" Style="background-image: url(../App_Themes/Default/images/email.png); background-repeat: no-repeat; background-position: 5px;" name="textfield" ID="Password" />
                            </div>
                            <div class="input_section">
                                <label>تکرار کلمه عبور</label>
                                <asp:RequiredFieldValidator ControlToValidate="ConfirmPassword" Display="Dynamic"
                                    ErrorMessage="تاییدیه کلمه عبور اجباری است" ID="ConfirmPasswordRequired" runat="server"
                                    ToolTip="تاییدیه کلمه عبور اجباری است" ValidationGroup="RegisterUserValidationGroup">*</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                    Display="Dynamic" ErrorMessage="کلمه عبور و تاییدیه کلمه عبور باید یکسان باشند"
                                    ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>
                                <asp:TextBox runat="server" TextMode="Password" Style="background-image: url(../App_Themes/Default/images/email.png); background-repeat: no-repeat; background-position: 5px;" name="textfield" ID="ConfirmPassword" />
                            </div>
                        </div>
                    </div>
                    <div class="vars_container">
                        <asp:Button ID="CreateUserButton" runat="server" CommandName="MoveNext" Text="ثبت نام"
                            ValidationGroup="RegisterUserValidationGroup" SkinID="MetroInsertModeButton" />
                        <span class="failureNotification">
                            <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                        </span>
                    </div>
                    <div dir="rtl">
                        <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" Display="Dynamic"
                            ValidationGroup="RegisterUserValidationGroup" />
                    </div>
                </ContentTemplate>
                <CustomNavigationTemplate>
                </CustomNavigationTemplate>
            </asp:CreateUserWizardStep>
            <asp:WizardStep ID="SpecifyRolesStep" runat="server" StepType="Step"
                Title="نقش ها" AllowReturn="False">
                <div class="rows">
                    <div class="input_section" style="width:400px">
                        <label>:نقش ها</label>
                        <asp:CheckBoxList ID="RoleList" runat="server" RepeatDirection="Vertical" TextAlign="Right" RepeatColumns="1">
                        </asp:CheckBoxList>
                        <div class="fields-container">
                            <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" Display="Dynamic"
                                ValidationGroup="RegisterUserValidationGroup" />
                        </div>
                    </div>
                </div>
            </asp:WizardStep>
            <asp:CompleteWizardStep ID="CompleteStep" runat="server">
                <ContentTemplate>
                    <p>
                        کاربر مورد  نظر با موفقیت ایجاد شد
                    </p>
                </ContentTemplate>
            </asp:CompleteWizardStep>
        </WizardSteps>
    </asp:CreateUserWizard>
</asp:Content>

