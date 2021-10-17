<%@ Page Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" CodeFile="PhotoCategory.aspx.cs" Inherits="Guest_PhotoCategory" %>

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
                    <span class="current"><a href='../../../<%= HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId] %>/آلبوم'>تصاویر</a></span>
                    <%}
                        else
                        {%>
                    <a href='../../../home'>صفحه اصلی</a> <span class="delimiter">/</span>
                    <span class="current"><a href='../../../آلبوم'>تصاویر</a></span>
                    <%} %>
                </div>
                <article class="page hentry">
  	                <header class="entry-header">
		                <h1 class="entry-title"><a href="#">گالری تصاویر</a></h1>
                    </header>
                     <div id="imagecontainer" class="entry-content" runat="server">
                    </div>
                  </article>
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
                            <ul class="box-category" id="PhotoCategoryContainer">
                                <asp:Repeater ID="PhotoCategoryListRepeater" runat="server">
                                    <ItemTemplate>
                                        <li><a href="../../../آلبوم/<%#Eval("Id")%>/<%#Eval("Title").ToString().Replace(" ","_")%>/<%#Eval("SchoolId") %>">
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
