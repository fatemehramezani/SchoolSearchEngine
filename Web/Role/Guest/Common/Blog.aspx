<%@ Page Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" CodeFile="Blog.aspx.cs" Inherits="Guest_Blog" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="main">
        <div id="primary">
            <div id="content" role="main">
                <div id="crumbs">
                    <% if (HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId] != null)
                        {%>
                    <a href='../../../<%= HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId]%>'>صفحه اصلی</a> <span class="delimiter">/</span>
                    <span class="current"><a href='../../../<%= HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId] %>/بلاگ'>بلاگ</a></span>
                    <%}
                        else
                        {%>
                    <a href='../../../home'>صفحه اصلی</a> <span class="delimiter">/</span>
                    <span class="current"><a href='../../../دانستنی'>بدانیم</a></span>
                    <%} %>
                </div>
                <div runat="server" id="BlogContent">
                    <asp:Repeater ID="BlogRepeater" runat="server">
                        <ItemTemplate>
                            <UserControl:BlogItem runat="server" />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <section>
                    <div class="row-fluid">
                                                <div class="col-lg-3 col-md-3 col-sm-12">
                             <h2 class="madreseyab">
                             <a href="http://www.madreseyab.com" title="مدرسه یاب">
                             آخرین ها
                             </a>
                             </h2>
                         </div>
                        <div class="col-lg-9 col-md-9 col-sm-12">
                            <ul class="box-category" id="BlogContainer">
                                <asp:Repeater ID="BlogListRepeater" runat="server">
                                    <ItemTemplate>
                                        <li><a href="../../../دانستنی/<%#Eval("Id")%>/<%#Eval("Title").ToString().Replace(" ","_")%>/<%#Eval("SchoolId") %>">
                                            <h5><%#Eval("Title")%></h5>
                                        </a></li>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </ul>          
                            </div>
                    </div>                            
                    <div class="container-fluid">
                    </div>
                    <div class="container-fluid">
                        <div class="col-xs-3"></div>
                        <div class="col-xs-6">
                            <UserControl:PagingControl ID="pagingControl" runat="server" EnableViewState="false" />
                        </div>
                        <div class="col-xs-3"></div>
                    </div>
                </section>
            </div>
        </div>
    </div>
</asp:Content>
