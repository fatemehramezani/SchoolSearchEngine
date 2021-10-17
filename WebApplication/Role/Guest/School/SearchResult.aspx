<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" Inherits="Role_Guest_School_SearchResult" Codebehind="SearchResult.aspx.cs" %>

<%@ Register Src="~/UserControl/School/Summary.ascx" TagName="SchoolInformation" TagPrefix="UserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="row hentry">
        <div class="col-lg-9 col-md-7 col-sm-12 searchform">
            <asp:Repeater ID="InformationRepeater" runat="server" EnableViewState="false">
                <ItemTemplate>
                    <UserControl:SchoolInformation runat="server" />
                </ItemTemplate>
            </asp:Repeater>
        </div>
        <div class="col-lg-3 col-md-5 col-sm-12">
            <h2 class="madreseyab">
                <a href="http://www.madreseyab.com" title="مدرسه یاب">مدارس یافته شده
                </a>
            </h2>
        </div>
    </div>
</asp:Content>


