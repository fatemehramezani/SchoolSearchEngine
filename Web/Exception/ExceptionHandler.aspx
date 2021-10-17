<%@ Page Language="C#" AutoEventWireup="true" CodeFile="ExceptionHandler.aspx.cs"
    Inherits="Exception_ExceptionHandler" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" %>

<asp:Content ID="HeaderContent" ContentPlaceHolderID="HeadContent" runat="Server">
    <style>
        .HelpTitle {
            font-size: 14pt;
            color: red;
            font-family: Tahoma;
            background: #bad9ff;
            border: #99ccff thin solid;
            text-align: center;
        }

        .HelpOriginalMessage {
            font-size: 14pt;
            color: red;
            font-family: Tahoma;
            background: #bad9ff;
            border: #3399ff thin solid;
            direction: ltr;
            text-align: left;
        }

        .HelpDescription {
            border: #3399cc thin solid;
            color: #3399cc;
        }

        .HelpNote {
            border: #3399cc thin solid;
            color: #3399cc;
        }

        span {
            font-size: 20px;
        }
    </style>
</asp:Content>
<asp:Content ID="TitleContent" ContentPlaceHolderID="TitleContent" runat="Server">
    خطا
</asp:Content>
<asp:Content ID="MainContent" ContentPlaceHolderID="RightContent" runat="Server">
    <div class="movie-best" style="height: 200px;">
 
    </div>
    <div class="clearfix"></div>
    <h2 id='target' class="page-heading heading--outcontainer">خطا</h2>

    <div class="col-sm-12">
        <div class="row">
            <div class="col-sm-8 col-md-9">
                <div class="axkh bord3" dir="rtl">
                    <asp:HyperLink ID="ReturnHyperLink" runat="server">بازگشت</asp:HyperLink>
                    <a href="#" class="toggleclick">
                        <div class="HelpTitle">
                            <asp:Label ID="TitleLabel" runat="server" Text="Label" SkinID="Description"></asp:Label>
                        </div>
                    </a>
                    <div class="togglebox-show">
                        <table style="width: 100%; height: 100%; border: #99ccff thin solid; background-color: #cfe3ff;" border="0" cellpadding="2" cellspacing="2">
                            <tr>
                                <td valign="top" class="HelpOriginalMessage">
                                    <asp:Label ID="OriginalMessageLabel" runat="server" Text="Label" SkinID="Description"></asp:Label>
                                </td>
                            </tr>
                            <tr>
                                <td valign="top" class="HelpDescription" style="border-right: #3399cc thin solid; border-top: #3399cc thin solid; border-left: #3399cc thin solid; border-bottom: #3399cc thin solid" colspan="2">
                                    <asp:Label ID="MessageLabel" runat="server" Text="Label" SkinID="Description"></asp:Label></td>
                            </tr>
                            <tr>
                                <td valign="top" class="HelpNote" rowspan="">
                                    <asp:Label ID="HelpNoteLabel" runat="server" Text="Label" SkinID="Description"></asp:Label>&nbsp;</td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </div>
        <div class="clearfix"></div>
    </div>
</asp:Content>
