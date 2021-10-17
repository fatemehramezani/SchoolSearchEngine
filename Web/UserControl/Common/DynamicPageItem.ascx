<%@ Control Language="C#" AutoEventWireup="true" CodeFile="DynamicPageItem.ascx.cs" Inherits="UserControl_Common_DynamicPageItem" %>
<% if(string.IsNullOrEmpty(Name)) {%>
<div>
    <%#Eval("Content") %>
</div>
<%} else {%>
<div>
    <asp:PlaceHolder ID="pageDiv" runat="server" />
</div>
<%} %>