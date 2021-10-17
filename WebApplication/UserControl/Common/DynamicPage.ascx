<%@ Control Language="C#" AutoEventWireup="true" Inherits="UserControl_Common_DynamicPage" Codebehind="DynamicPage.ascx.cs" %>
<% if(string.IsNullOrEmpty(Name)) {%>
<div>
    <%#Eval("Content") %>
</div>
<%} else {%>
<div>
    <asp:PlaceHolder ID="pageDiv" runat="server" />
</div>
<%} %>