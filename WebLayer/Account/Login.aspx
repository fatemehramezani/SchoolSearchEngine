<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Login.aspx.cs" Inherits="WebLayer.Account.Login" %>
<%@ Register Src="~/Account/OpenAuthProviders.ascx" TagPrefix="uc" TagName="OpenAuthProviders" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>پنل مدیریت سایت مدرسه </title>
    <script type="text/javascript" src="../App_Themes/Panel/js/jquery-1.10.1.min.js"></script>
    <script src="../App_Themes/Panel/login/modernizr.js"></script>
    <link href="../App_Themes/Default/css/login.css" rel="stylesheet" />
    <!--placeholder-->
    <script>
        $(document).ready(function () {
            if (!Modernizr.input.placeholder) {

                $('[placeholder]').focus(function () {
                    var input = $(this);
                    if (input.val() == input.attr('placeholder')) {
                        input.val('');
                        input.removeClass('placeholder');
                    }
                }).blur(function () {
                    var input = $(this);
                    if (input.val() == '' || input.val() == input.attr('placeholder')) {
                        input.addClass('placeholder');
                        input.val(input.attr('placeholder'));
                    }
                }).blur();
                $('[placeholder]').parents('form').submit(function () {
                    $(this).find('[placeholder]').each(function () {
                        var input = $(this);
                        if (input.val() == input.attr('placeholder')) {
                            input.val('');
                        }
                    })
                });
            }
        });
    </script>
</head>

<body>
    <form id="Form1" runat="server">
        <div id="loginwrapper">
            <asp:Login ID="LoginUser" runat="server" EnableViewState="false" FailureText="نام کاربری یا کلمه عبور شما اشتباه است" RenderOuterTable="false" OnLoggedIn="LoginUser_LoggedIn">
                <LayoutTemplate>
                    <img src="App_Themes/Panel/login/title.png" width="242" height="36" alt="ورود به سیستم رزرو بلیت" />
                    <div id="input_wrapper">
                        <asp:TextBox runat="server" class="field" ID="UserName" autocomplete="off" type="text" required="" title="نام کاربری را وارد کنید" name="نام کاربری" placeholder="نام کاربری" data-icon="U" />
                        <asp:TextBox class="field" ID="Password" runat="server" autocomplete="off" TextMode="password" required="" title="کلمه عبور را وارد کنید" placeholder="کلمه عبور" data-icon="x" />
                    </div>
                    <div id="bottom">
                        <div id="bottom_right">
                            <!--<div id="botton_right_one"><a href="Register.aspx?Roles=VGVhY2hlcg==">عضویت</a></div>-->
                            <div id="botton_right_two">
                                <asp:CheckBox runat="server" Text="ذخیره سازی" ID="RememberMe"></asp:CheckBox>
                                </div>
                        </div>
                        <div id="bottom_left">
                            <asp:ImageButton ID="LoginButton" runat="server" CommandName="Login" ValidationGroup="LoginUserValidationGroup" SkinID="LoginButton" />
                        </div>
                    </div>
                </LayoutTemplate>
            </asp:Login>
        </div>


          <h2><%: Title %>.</h2>

    <div class="row">
        <div class="col-md-8">
            <section id="loginForm">
                <div class="form-horizontal">
                    <h4>Use a local account to log in.</h4>
                    <hr />
                    <asp:PlaceHolder runat="server" ID="ErrorMessage" Visible="false">
                        <p class="text-danger">
                            <asp:Literal runat="server" ID="FailureText" />
                        </p>
                    </asp:PlaceHolder>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Email" CssClass="col-md-2 control-label">Email</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Email" CssClass="form-control" TextMode="Email" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Email"
                                CssClass="text-danger" ErrorMessage="The email field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <asp:Label runat="server" AssociatedControlID="Password" CssClass="col-md-2 control-label">Password</asp:Label>
                        <div class="col-md-10">
                            <asp:TextBox runat="server" ID="Password" TextMode="Password" CssClass="form-control" />
                            <asp:RequiredFieldValidator runat="server" ControlToValidate="Password" CssClass="text-danger" ErrorMessage="The password field is required." />
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <div class="checkbox">
                                <asp:CheckBox runat="server" ID="RememberMe" />
                                <asp:Label runat="server" AssociatedControlID="RememberMe">Remember me?</asp:Label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <div class="col-md-offset-2 col-md-10">
                            <asp:Button runat="server" OnClick="LogIn" Text="Log in" CssClass="btn btn-default" />
                        </div>
                    </div>
                </div>
                <p>
                    <asp:HyperLink runat="server" ID="RegisterHyperLink" ViewStateMode="Disabled">Register as a new user</asp:HyperLink>
                </p>
                <p>
                    <%-- Enable this once you have account confirmation enabled for password reset functionality
                    <asp:HyperLink runat="server" ID="ForgotPasswordHyperLink" ViewStateMode="Disabled">Forgot your password?</asp:HyperLink>
                    --%>
                </p>
            </section>
        </div>

        <div class="col-md-4">
            <section id="socialLoginForm">
                <uc:OpenAuthProviders runat="server" ID="OpenAuthLogin" />
            </section>
        </div>
    </div>

    </form>
</body>
</html>

