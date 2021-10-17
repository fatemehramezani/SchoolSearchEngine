<%@ Page Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" Inherits="Guest_News" Codebehind="News.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">

    <div id="main">
        <div id="primary">
            <div id="content" role="main">
                <div id="crumbs">
                    <a href="../home">صفحه اصلی</a> <span class="delimiter">/</span>
                    <span class="current"><a href="../خبر">آگاه شویم</a></span>
                </div>
                <div runat="server" id="NewsContent">
                </div>
                <ul class="box-category" id="NewsContainer" runat="server">
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
