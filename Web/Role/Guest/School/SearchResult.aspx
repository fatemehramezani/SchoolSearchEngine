<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" CodeFile="SearchResult.aspx.cs" Inherits="Role.Guest.School.SearchResult" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
    <link href="../../App_Themes/Default/css/school.css" rel="stylesheet" />
    <script src="../../Script/School/summary.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="Server">
    <section>
        <div class="row hentry">
            <div class="col-lg-10 col-md-12 col-sm-12 col-xs-12 searchform">
                <div class="panel-group">
                    <asp:Repeater ID="InformationRepeater" runat="server" EnableViewState="false">
                        <ItemTemplate>
                            <UserControl:SchoolInformation runat="server" />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
           <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12">
                <h2 class="madreseyab">
                    <a href="http://www.madreseyab.com" title="مدرسه یاب">مدارس یافته شده
                    </a>
                </h2>
            </div>
        </div>
        <div class="row hentry">
            <div class="container-fluid">
            </div>
            <div class="container-fluid">
                <div class="col-xs-3"></div>
                <div class="col-xs-6 bbcnasim">
                    <UserControl:PagingControl ID="pagingControl" runat="server" EnableViewState="false" />
                </div>
                <div class="col-xs-3"></div>
            </div>
        </div>
    </section>
    <section>
        <div class="row hentry">
            <div class="col-lg-10 col-md-12 col-sm-12 col-xs-12 searchform">
                <div class="panel-group">
                    <asp:Repeater ID="LastRepeater" runat="server" EnableViewState="false">
                        <ItemTemplate>
                            <UserControl:SchoolInformation runat="server" />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
           <div class="col-lg-2 col-md-12 col-sm-12 col-xs-12">
                <h2 class="madreseyab">
                    <a href="http://www.madreseyab.com" title="مدرسه یاب">جدیدترین مدارس
                    </a>
                </h2>
            </div>
        </div>
       </section>
</asp:Content>


