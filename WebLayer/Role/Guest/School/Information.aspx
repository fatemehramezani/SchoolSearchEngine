<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/SchoolMasterPage.master" AutoEventWireup="true" Inherits="Role.Guest.School.Information" Codebehind="Information.aspx.cs" %>

<%@ Register Src="~/UserControl/School/Item.ascx" TagName="SchoolItem" TagPrefix="UserControl" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="../../../Script/School/information.js" type="text/javascript"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <asp:Repeater ID="InformationRepeater" runat="server" EnableViewState="false">
        <ItemTemplate>
            <UserControl:SchoolItem runat="server" />
        </ItemTemplate>
    </asp:Repeater>
</asp:Content>

