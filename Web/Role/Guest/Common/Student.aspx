<%@ Page Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" CodeFile="Student.aspx.cs" Inherits="Guest_Student" %>
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
                    <span class="current"><a href='../../../<%= HttpContext.Current.Request.RequestContext.RouteData.Values[Utility.Common.SchoolId] %>/برتر'>دانش آموزان برتر مدرسه</a></span>
                    <%}
                    else
                    {%>
                    <a href='../../../home'>صفحه اصلی</a> <span class="delimiter">/</span>
                    <span class="current"><a href='../../../برتر'>دانش آموزان برتر</a></span>
                    <%} %>
                </div>
                <div runat="server" id="StudentContent">
                    <asp:Repeater ID="StudentRepeater" runat="server">
                        <ItemTemplate>
                            <UserControl:StudentItem runat="server" />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <section>
                    <div class="row-fluid">
                        <div class="col-lg-3 col-md-3 col-sm-12">
                             <h2 class="madreseyab">
                             <a href="http://www.madreseyab.com" title="مدرسه یاب">
                             دانش آموزان برتر مدرسه
                             </a>
                             </h2>
                         </div>
                        <div class="col-lg-9 col-md-9 col-sm-12">
                            <ul class="box-category" id="StudentContainer">
                                <asp:Repeater ID="StudentListRepeater" runat="server">
                                    <ItemTemplate>
                                        <li><a href="../../../برتر/<%#Eval("Id")%>/<%#Eval("Title").ToString().Replace(" ","_")%>_<%# Eval("FirstName").ToString().Replace(" ","_") %>_<%# Eval("LastName").ToString().Replace(" ","_")%>/<%#Eval("SchoolId") %>">
                                            <h5><%#Eval("Title")%> <%#Eval("FirstName")%> <%#Eval("LastName")%></h5>
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
