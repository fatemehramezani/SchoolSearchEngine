<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Keyword.ascx.cs" Inherits="UserControl_Common_Keyword" %>
<div class="container-fluid">
    <asp:Repeater ID="keywordRepeater" runat="server" EnableViewState="false">
        <ItemTemplate>
            <a href="search/filterid=<%#Eval("Id") %>&مدرسه-<%#Eval("title").ToString().Replace(" ","-") %>" onclick="doClick(<%#Eval("Id") %>,<%#Eval("Title") %>); return false;" class="btn btn-default btn-sm keywordbox" title="<%#Eval("Title")%>"><%#Eval("Title") %></a>
        </ItemTemplate>
    </asp:Repeater>
</div>
<script type="text/javascript">
    function doClick(id, title) {
        if (id == 2147483647)
            window.location.href = "http://www.madreseyab.com";
        else
            window.location.href = "search/" + id + "/" + title;
    }
</script>
