<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" Inherits="Guest_Photo" Codebehind="Photo.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script language="javascript" type="text/javascript">
        function OpenPhoto(id, title) {
            window.location.href = "../../photo/" + id + "/" + title;
        }
    </script>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="Server">
    <div id="main">
        <div id="primary">
            <div id="content" role="main">
                <div id="crumbs">
                    <a href="../home">صفحه اصلی</a> <span class="delimiter">/</span>
                    <span class="current"><a href="../photo">تصاویر</a></span>
                </div>
                <article class="page hentry">
  	                <header class="entry-header">
		                <h1 class="entry-title"><a href="#">گالری تصاویر</a></h1>
                    </header>
                     <div id="imagecontainer" class="entry-content" runat="server">
                    </div>
                  </article>
                <ul class="box-category">
                    <asp:EntityDataSource ID="PhotoEntityDataSource" runat="server" ConnectionString="name=DatabaseEntities" DefaultContainerName="DatabaseEntities" EnableFlattening="False" EntitySetName="Photos" OrderBy=" it.Id desc">
                    </asp:EntityDataSource>
                    <asp:ListView ID="PhotoListView" runat="server" DataSourceID="PhotoEntityDataSource" DataKeyNames="Id">
                        <EmptyDataTemplate>
                        </EmptyDataTemplate>
                        <ItemTemplate>
                            <li>
                                <asp:HyperLink ID="PhotoHyperLink" NavigateUrl=<%# String.Format("javascript:OpenPhoto( '{0}','{1}')", Eval("Id"),Eval("Title")) %> runat="server">
                                <h5>
                                   <%# Eval("Title") %>
                                </h5>
                                </asp:HyperLink>
                            </li>
                        </ItemTemplate>
                    </asp:ListView>
                </ul>
            </div>
        </div>
    </div>
</asp:Content>

