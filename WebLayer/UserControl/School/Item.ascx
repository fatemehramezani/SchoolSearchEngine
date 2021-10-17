<%@ Control Language="C#" AutoEventWireup="true" Inherits="UserControl_School_Item" Codebehind="Item.ascx.cs" %>
<%@ Register Src="~/UserControl/Common/MenuItem.ascx" TagName="MenuItem" TagPrefix="UserControl" %>
<link href="../../App_Themes/Default/css/school.css" rel="stylesheet" />
<script src="../../Script/School/school.js"></script>
<style>
    body {
        background: #2e2e2e url(images/bg1.jpg) repeat fixed;
    }
</style>
<asp:HiddenField ID="SchoolIdHiddenField" runat="server" ClientIDMode="Static" Value='<%#Eval("Id") %>' />
<!-- Menu -->
<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header page-scroll" style="visibility: hidden">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target=".navbar-main-collapse">
                <i class="fa fa-bars"></i>
            </button>
            <a class="navbar-brand" href="مدرسه_یاب" style="padding-right: 150px;" title="مدرسه یاب" rel="home">
                <img height="50" runat="server" src="~/App_Themes/Default/images/logo.png" alt="مدرسه_یاب" />
            </a>
        </div>
        <!-- Collect the nav links, forms, and other content for toggling -->
        <div class="navbar-collapse navbar-right navbar-main-collapse collapse" style="height: 0.666667px;">
            <ul class="nav navbar-nav" id="tiny">
                <asp:Repeater runat="server" ID="MenuRepeater" DataSourceID="SchoolSiteMapDataSource">
                    <ItemTemplate>
                        <usercontrol:menuitem runat="server"/>
                    </ItemTemplate>
                </asp:Repeater>
                <asp:SiteMapDataSource ID="SchoolSiteMapDataSource" runat="server" ShowStartingNode="False" SiteMapProvider="School" />
            </ul>
        </div>
        <!-- /.navbar-collapse -->
    </div>
    <!-- /.container -->
</nav>
<div class="row">
    <img src="../../Files/School/Banners/<%#Eval("ApplicantId") %>/<%#Eval("BannerURL") %>" style="width: 100%; max-height: 200px;" />
</div>
<div class="row hentry">
    <div class="col-lg-3 col-md-3 col-sm-4 col-sm-12">
        <h2 class="madreseyab">
            <a href="<%#Eval("Id") %>" title="مدرسه یاب">مدرسه <%# Eval("Name")%>
            </a>
        </h2>
    </div>
    <div class="col-lg-9 col-md-9 col-sm-8 col-sm-12 searchform">
        <div><%# Eval("Features") %></div>
    </div>
</div>

<!--<script>
var parser, xmlDoc;
var text = "<bookstore><book>" +
"<title>Everyday Italian</title>" +
"<author>Giada De Laurentiis</author>" +
"<year>2005</year>" +
"</book></bookstore>";

parser = new DOMParser();
xmlDoc = parser.parseFromString(text,"text/xml");

document.getElementById("demo").innerHTML =
xmlDoc.getElementsByTagName("title")[0].childNodes[0].nodeValue + "<br>" +
xmlDoc.getElementsByTagName("author")[0].childNodes[0].nodeValue + "<br>" +
xmlDoc.getElementsByTagName("year")[0].childNodes[0].nodeValue;
</script>-->
