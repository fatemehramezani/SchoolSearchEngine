<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Register.aspx.cs" Inherits="Register" Culture="auto" UICulture="auto" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>مدرسه یاب|جستجو در بین  مدارس کشور</title>
    <script type="text/javascript" src="App_Themes/Panel/js/jquery-1.10.1.min.js"></script>
    <script src="App_Themes/Panel/login/modernizr.js"></script>
    <link href="App_Themes/Default/css/login.css" rel="stylesheet" />   
</head>

<body>
    <form id="Form1" runat="server"> 
        <div id="descriptionwrapper" class="col-lg-9 col-md-8 col-sm-12 box">
            <UserControl:DynamicPageItem runat="server" Name="Register" />
        </div>     
        <div id="loginwrapper" class="col-lg-3 col-sm-4 col-md-6 box">
            <asp:CreateUserWizard ID="RegisterUser" runat="server" OnCreatedUser="RegisterUser_CreatedUser" ContinueDestinationPageUrl="~/Role/User/Default.aspx">
                <WizardSteps>
                    <asp:CreateUserWizardStep ID="RegisterUserWizardStep" runat="server">
                        <ContentTemplate>
                            <img src="App_Themes/Panel/login/title.png" width="242" height="36" alt="ورود به سیستم مدرسه یاب" />
                            <div id="input_wrapper">
                                <asp:TextBox ID="UserName" autocomplete="off" type="text" required="" title="نام کاربری را وارد کنید" placeholder="نام کاربری" data-icon="U" CssClass="field" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="UserNameRequired" runat="server" ControlToValidate="UserName"
                                    ErrorMessage="نام کاربری اجباری است" ToolTip="نام کاربری اجباری است."
                                    ValidationGroup="RegisterUserValidationGroup" Display="Dynamic">* نام کاربری را وارد نمایید </asp:RequiredFieldValidator>
                                <br />
                                <asp:TextBox ID="Email" title="آدرس الکترونیکی را وارد کنید" placeholder="آدرس الکترونیکی" data-icon="U" CssClass="field" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="EmailRequired" runat="server" ControlToValidate="Email"
                                    ErrorMessage="آدرس الکترونیکی اجباری است." ToolTip="آدرس الکترونیکی اجباری است"
                                    ValidationGroup="RegisterUserValidationGroup" Display="Dynamic">*آدرس الکترونیکی را وارد نمایید</asp:RequiredFieldValidator>
                                <br />
                                <asp:TextBox ID="Password" title="رمز عبور را وارد کنید" TextMode="Password" placeholder="رمز عبور" data-icon="x" CssClass="field" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="PasswordRequired" runat="server" ControlToValidate="Password"
                                    ErrorMessage="رمز عبور اجباری است." ToolTip="Password is required." Display="Dynamic"
                                    ValidationGroup="RegisterUserValidationGroup">*رمز عبور را وارد نمایید</asp:RequiredFieldValidator>
                                <br />
                                <asp:TextBox ID="ConfirmPassword" title="تاییدیه رمز عبور را وارد کنید" TextMode="Password" placeholder="تاییدیه رمز عبور" data-icon="x" CssClass="field" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ControlToValidate="ConfirmPassword" Display="Dynamic"
                                    ErrorMessage="تاییدیه رمز عبور اجباری است" ID="ConfirmPasswordRequired" runat="server"
                                    ToolTip="تاییدیه رمز عبور اجباری است." ValidationGroup="RegisterUserValidationGroup">*رمز عبور را تکرار نمایید</asp:RequiredFieldValidator>
                                <asp:CompareValidator ID="PasswordCompare" runat="server" ControlToCompare="Password" ControlToValidate="ConfirmPassword"
                                    Display="Dynamic" ErrorMessage="رمز عبور و تاییدیه رمز عبور باید یکسان باشند."
                                    ValidationGroup="RegisterUserValidationGroup">*</asp:CompareValidator>

                                <span>
                                    <asp:Literal ID="ErrorMessage" runat="server"></asp:Literal>
                                </span>
                                <asp:ValidationSummary ID="RegisterUserValidationSummary" runat="server" ValidationGroup="RegisterUserValidationGroup" />
                            </div>
                        </ContentTemplate>
                        <CustomNavigationTemplate>
                            <div id="bottom_left">
                                <asp:Button ID="StepNextButton" runat="server" CssClass="btn btn-default" CommandName="MoveNext" Text="ثبت نام" ValidationGroup="RegisterUserValidationGroup" />
                            </div>
                            <br />
                            <div id="bottom_right">
                                <h6>رمز عبور باید حداقل کاراکتر باشد.
                                </h6>
                            </div>
                        </CustomNavigationTemplate>
                    </asp:CreateUserWizardStep>
                    <asp:CompleteWizardStep ID="RegisterCompleteWizardStep" runat="server">
                        <ContentTemplate>
                            <div class="fields-container">
                                <p style="color: #FFF; direction: rtl; text-align: justify;">
                                    مدیر محترم، کاربر شما با موفقیت اضافه شد
                                </p>
                            </div>
                            <div class="fields-container" style="padding-right: 0px !important; margin-left: 0px !important;">
                                <asp:Button ID="ContinueButton" runat="server" CausesValidation="False" CommandName="Continue" OnClick="ContinueButton_Click" Text="ادامه" ValidationGroup="RegisterUserValidation" meta:resourcekey="ContinueButtonResource1" />
                            </div>
                        </ContentTemplate>
                    </asp:CompleteWizardStep>
                </WizardSteps>
                <FinishNavigationTemplate>
                    <asp:Button runat="server" CausesValidation="False" CommandName="MovePrevious" Text="بازگشت" ID="FinishPreviousButton"></asp:Button>
                    <asp:Button runat="server" CommandName="MoveComplete" Text="پایان" ID="FinishButton"></asp:Button>
                </FinishNavigationTemplate>
            </asp:CreateUserWizard>
        </div>
        
    </form>
</body>
</html>

