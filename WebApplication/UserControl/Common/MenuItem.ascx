<%@ Control Language="C#" AutoEventWireup="true" Inherits="UserControl_Common_MenuItem" Codebehind="MenuItem.ascx.cs" %>
<li class="menu_item down">
    <a href='<%# Eval("url")%>' target="_self" runat="server" data-schoolid='<%#SchoolId%>'>
        <%# Eval("title") %>
    </a>
</li>
