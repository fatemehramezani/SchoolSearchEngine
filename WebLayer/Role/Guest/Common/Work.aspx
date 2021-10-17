<%@ Page Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" Inherits="Guest_Work" Codebehind="Work.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">

    <div id="main">
        <div id="primary">
            <div id="content" role="main">
                <div id="crumbs">
                    <a href="../home">صفحه اصلی</a> <span class="delimiter">/</span>
                    <span class="current"><a runat="server" href="~/work">کار ها</a></span>
                </div>
                                <div runat="server" id="WorkContent">
                </div>
                <ul class="box-category" id="WorkContainer" runat="server">
                </ul>
            </div>
        </div>
    </div>
</asp:Content>
