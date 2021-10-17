<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" CodeFile="DynamicPage.aspx.cs" Inherits="Guest_AboutUs" %>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="main">
        <div id="primary">
            <div id="content" role="main">
                <div id="crumbs">
                    <a href="../بیابیم">صفحه اصلی</a>
                </div>
                <asp:Repeater ID="DynamicPageRepeater" runat="server" EnableViewState="false">
                    <ItemTemplate>
                        <UserControl:DynamicPageItem runat="server" />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>

