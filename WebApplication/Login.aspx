<%@ Page Language="C#" AutoEventWireup="true" Inherits="Login" Codebehind="Login.aspx.cs" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head id="Head1" runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>پنل مدیریت سایت مدرسه </title>
    <script type="text/javascript" src="App_Themes/Panel/js/jquery-1.10.1.min.js"></script>
    <script src="App_Themes/Panel/login/modernizr.js"></script>
    <link href="App_Themes/Default/css/login.css" rel="stylesheet" />
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
    </form>
</body>
</html>

