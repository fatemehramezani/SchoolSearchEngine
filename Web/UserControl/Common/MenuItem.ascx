<%@ Control Language="C#" AutoEventWireup="true" CodeFile="MenuItem.ascx.cs" Inherits="UserControl_Common_MenuItem" %>
<li class="menu_item down">
    <a href='<%# Eval("url")%>' target="_self" runat="server" data-schoolid='<%#SchoolId%>'>
        <%# Eval("title") %>
    </a>
</li>
