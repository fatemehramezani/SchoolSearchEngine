<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" Inherits="Guest_AboutUs" Codebehind="DynamicPage.aspx.cs" %>

<%@ Register Src="~/UserControl/Common/DynamicPage.ascx" TagName="DynamicPage" TagPrefix="UserControl" %>
<%--<%@ OutputCache Duration="10" VaryByParam="None" %>--%>

<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="main">
        <div id="primary">
            <div id="content" role="main">
                <div id="crumbs">
                    <a href="../بیابیم">صفحه اصلی</a>
                </div>
                <asp:Repeater ID="DynamicPageRepeater" runat="server" EnableViewState="false">
                    <ItemTemplate>
                        <UserControl:DynamicPage runat="server" />
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </div>
</asp:Content>

