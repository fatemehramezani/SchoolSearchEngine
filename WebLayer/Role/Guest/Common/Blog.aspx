<%@ Page Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" Inherits="Guest_Blog" Codebehind="Blog.aspx.cs" %>
<%@ Register Src="~/UserControl/Common/BlogItem.ascx" TagName="BlogItem" TagPrefix="UserControl" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="Server">

    <div id="main">
        <div id="primary">
            <div id="content" role="main">
                <div id="crumbs">
                    <a href="../home">صفحه اصلی</a> <span class="delimiter">/</span>
                    <span class="current"><a href="../بدانیم">بدانیم</a></span>
                </div>
                <div runat="server" id="BlogContent">
                    <asp:Repeater ID="BlogRepeater" runat="server">
                        <ItemTemplate>
                            <UserControl:BlogItem runat="server" />
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
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
    </div>
</asp:Content>
