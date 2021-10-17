<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/SchoolMasterPage.master" AutoEventWireup="true" CodeFile="Information.aspx.cs" Inherits="Role.Guest.School.Information" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
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

