<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/PanelMasterPage.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" Runat="Server">
    کاربر گرامی <%= Profile.FullName %>،<br />
             به سامانه مدیریت سایت مدرسه خود در مدرسه یاب خود خوش آمدید
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="DescriptionContent" Runat="Server">      
    این پنل مخصوص مدیران سایت می باشد که می توانند از طریق آن به مدیریت صفحات مربوط به سایت مدرسه یاب بپردازند
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" Runat="Server">      
</asp:Content>

