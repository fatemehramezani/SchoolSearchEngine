<%@ Page Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" CodeFile="UnauthorizedAccess.aspx.cs" Inherits="UnauthorizedAccess" Title="دسترسی نامجاز" %>

<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" Runat="Server">
خطای دسترسی نامعتبر</asp:Content>
<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" Runat="Server">
         <div class="movie-best" style="height:200px;">

    </div>
    <div class="clearfix"></div>
<h2 dir="rtl" style="color: red !important;text-align: center">
       شما در حال تلاش برای دیدن صفحه ای هستید که اجازه دسترسی به آن را ندارید.
    <br/>
        در صورت اطلاع از دسترسی به این صفحه با مدیر سیستم تماس بگیرید.
    <asp:HyperLink ID="returnHyperLink" Text="بازگشت" NavigateUrl="~/Default.aspx" runat="server" />
    </h2>
</asp:Content>
