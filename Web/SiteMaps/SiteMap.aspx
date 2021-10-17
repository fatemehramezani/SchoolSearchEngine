<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" CodeFile="SiteMap.aspx.cs" Inherits="SiteMaps_SiteMap" %>
<%@ OutputCache Duration="10000" VaryByParam="none" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="Server">
    <section>
        <div class="row hentry">
            <div class="col-lg-10 col-md-12 col-sm-12 col-xs-12 searchform">
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="panel-group">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse1" class="" aria-expanded="true">
                                    <h2>صفحات اصلی</h2>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse1" class="panel-collapse collapse" aria-expanded="true">
                             <div class="panel-body speed_help_body">  
                                  <ul class="box-category" id="MenuContainer">
                                     <asp:Repeater runat="server" ID="MenuRepeater" DataSourceID="UserSiteMapDataSource">
                                        <ItemTemplate>
                                              <li><a runat="server" href='<%# Eval("url")%>' title='<%# Eval("title") %>'>
                                                    <h5><%#Eval("Title")%></h5>
                                                  </a>
                                              </li>                            	            
                                            <br/>  
                                        </ItemTemplate>
                                     </asp:Repeater>
                                     <asp:SiteMapDataSource ID="UserSiteMapDataSource" runat="server" ShowStartingNode="False" SiteMapProvider="Default"/>                      
                                  </ul>
                           </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="panel-group">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse2" class="" aria-expanded="true">
                                    <h2>آخرین اخبار</h2>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse2" class="panel-collapse collapse" aria-expanded="true">
                            <div class="panel-body speed_help_body">  
                                  <ul class="box-category" id="NewsContainer">
                                    <asp:Repeater ID="NewsRepeater" runat="server">
                                        <ItemTemplate>
                                            <li><a href="../../خبر/<%#Eval("Id")%>/<%#Eval("Title").ToString().Replace(" ","_")%>">
                                                <h5><%#Eval("Title")%></h5>
                                            </a></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                  </ul>   
                           </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="panel-group">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse3" class="" aria-expanded="true">
                                    <h2>آخرین بلاگ</h2>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse3" class="panel-collapse collapse" aria-expanded="true">
                            <div class="panel-body speed_help_body">  
                                  <ul class="box-category" id="BlogContainer">
                                    <asp:Repeater ID="BlogRepeater" runat="server">
                                        <ItemTemplate>
                                            <li><a href="../../دانستنی/<%#Eval("Id")%>/<%#Eval("Title").ToString().Replace(" ","_")%>">
                                                <h5><%#Eval("Title")%></h5>
                                            </a></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                  </ul>   
                           </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="panel-group">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse4" class="" aria-expanded="true">
                                    <h2>مدارس استانها</h2>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse4" class="panel-collapse collapse" aria-expanded="true">
                            <div class="panel-body speed_help_body">  
                                  <ul class="box-category" id="ProvienceContainer">
                                    <asp:Repeater ID="ProvienceRepeater" runat="server">
                                        <ItemTemplate>
                                            <li><a href="../../search/provience=<%#Eval("Id")%>&<%#Eval("Title").ToString().Replace(" ","_")%>">
                                                <h5>مدارس استان <%#Eval("Title")%></h5>
                                            </a></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                  </ul>   
                           </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="panel-group">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse5" class="" aria-expanded="true">
                                    <h2>مدارس شهرستانها</h2>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse5" class="panel-collapse collapse" aria-expanded="true">
                            <div class="panel-body speed_help_body">  
                                  <ul class="box-category" id="CityContainer">
                                    <asp:Repeater ID="CityRepeater" runat="server">
                                        <ItemTemplate>
                                            <li><a href="../../search/city=<%#Eval("Id")%>&<%#Eval("Title").ToString().Replace(" ","_")%>">
                                                <h5>مدارس شهر <%#Eval("Title")%></h5>
                                            </a></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                  </ul>   
                           </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="panel-group">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse6" class="" aria-expanded="true">
                                    <h2>مدارس مناطق</h2>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse6" class="panel-collapse collapse" aria-expanded="true">
                            <div class="panel-body speed_help_body">  
                                  <ul class="box-category" id="RegionContainer">
                                    <asp:Repeater ID="RegionRepeater" runat="server">
                                        <ItemTemplate>
                                            <li><a href="../../search/region=<%#Eval("Id")%>&<%#Eval("Title").ToString().Replace(" ","_")%>">
                                                <h5>مدارس منطقه <%#Eval("Title")%></h5>
                                            </a></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                  </ul>   
                           </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="panel-group">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse7" class="" aria-expanded="true">
                                    <h2>آخرین مدارس</h2>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse7" class="panel-collapse collapse" aria-expanded="true">
                            <div class="panel-body speed_help_body">  
                                  <ul class="box-category" id="SchoolContainer">
                                    <asp:Repeater ID="SchoolRepeater" runat="server">
                                        <ItemTemplate>
                                            <li><a href="../../<%#Eval("Id")%>&<%#Eval("Name").ToString().Replace(" ","_")%>">
                                                <h5>مدرسه <%#Eval("Name")%></h5>
                                            </a></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                  </ul>   
                           </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                    <div class="panel-group">
                        <div class="panel-heading">
                            <h4 class="panel-title">
                                <a data-toggle="collapse" href="#collapse8" class="" aria-expanded="true">
                                    <h2>مشخصات مدرسه</h2>
                                </a>
                            </h4>
                        </div>
                        <div id="collapse8" class="panel-collapse collapse" aria-expanded="true">
                            <div class="panel-body speed_help_body">  
                                  <ul class="box-category" id="CommonContainer">
                                    <asp:Repeater ID="CommonRepeater" runat="server">
                                        <ItemTemplate>
                                            <li><a href="../../search/filterid=<%#Eval("Id")%>&<%#Eval("Title").ToString().Replace(" ","_")%>">
                                                <h5>مدارس <%#Eval("Title")%></h5>
                                            </a></li>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                  </ul>   
                           </div>
                        </div>
                    </div>
                </div>
            </div>
           <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12">
                <h2 class="madreseyab">
                    <a href="http://www.madreseyab.com" title="مدرسه یاب">صفحات مدرسه یاب
                    </a>
                </h2>
            </div>
        </div>
    </section>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomContent" runat="Server">
</asp:Content>
