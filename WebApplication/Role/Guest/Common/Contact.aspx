<%@ Page Title="تماس با ما" Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" Inherits="Guest_Contact" Codebehind="Contact.aspx.cs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script type="text/javascript">
        $('#contactform').submit(function () {
            // Get all the forms elements and their values in one step
            var values = $(this).serialize();
            alert(values);
        });
    </script>
    <script type="text/javascript">
        function submitContact() {
            alert('hi');
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="Server">

    <div id="main">
        <div id="primary">
            <div id="content" role="main">
                <div id="crumbs">
                    <a href="../Default.aspx">صفحه اصلی</a> <span class="delimiter">/</span>
                    <span class="current"><a href="../contact">تماس با ما</a></span>
                </div>
                <article class="page hentry">
  	                <header class="entry-header">
		                <h1 class="entry-title"><a href="#">تماس با ما</a></h1>
                    </header>
                    <div class="entry-content">
                    <div class="map full">
    	                <iframe width="100%" height="350" frameborder="0" scrolling="no" marginheight="0" marginwidth="0" src="http://maps.google.com/maps?ll=40.967132,29.07403&amp;spn=0.047894,0.132093&amp;vpsrc=6&amp;t=m&amp;z=14&amp;output=embed"></iframe>
                    </div>
                    <br>
                    <h3>لطفا در صورت تمایل پیام خود را ارسال نمایید</h3>
                    <p>توضیحات بسیار</p>
    
                                    لطفا در صورت بروز مشکل در سایت با  <a href="email:support@atlassaz.com">پشتیبانی</a> تماس بگیرید
                           <div class="form-container">
                      <div class="response"></div>
                                <br />
                                <asp:TextBox runat="server" ID="FullName" class="text-input defaultText required" title="نام و نام خانوادگی (اجباری)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ValidationGroup="Send" ControlToValidate="FullName" ErrorMessage="نام و نام خانوادگی اجباری است" ToolTip="نام و نام خانوادگی اجباری است" Display="Dynamic" ID="FullNameRequired">*</asp:RequiredFieldValidator>

                                <asp:TextBox runat="server" ID="Subject"  class="text-input defaultText" title="موضوع پیام (اجباری)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ValidationGroup="Send" ControlToValidate="Subject" ErrorMessage="موضوع اجباری است" ToolTip="موضوع اجباری است" Display="Dynamic" ID="SubjectValidator">*</asp:RequiredFieldValidator>

                                <asp:TextBox runat="server" ID="Email" class="text-input defaultText required email" title="آدرس الکترونیکی (اجباری)"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ControlToValidate="Email" ErrorMessage="آدرس الکترونیکی اجباری است" ToolTip="آدرس الکترونیکی اجباری است" Display="Dynamic" ID="RequiredFieldValidator1">*</asp:RequiredFieldValidator>
                                <asp:RegularExpressionValidator Display="Dynamic" ValidationGroup="Send" ID="EmailRegularExpressionValidator" runat="server" ErrorMessage="آدرس الکترونیکی معتبر وارد نمایید" ControlToValidate="Email" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*">*</asp:RegularExpressionValidator>

                                <asp:TextBox runat="server" ID="Description" class="text-area required" title="متن پیام" TextMode="MultiLine" Rows="5"></asp:TextBox>
                                <asp:RequiredFieldValidator runat="server" ValidationGroup="Send" ControlToValidate="Description" ErrorMessage="متن اجباری است" ToolTip="متن اجباری است" Display="Dynamic" ID="DescriptionValidator">*</asp:RequiredFieldValidator>

                               <asp:ValidationSummary runat="server" ValidationGroup="Send" />
                                <asp:Button ID="SendButton" runat="server" ValidationGroup="Send" Text="ارسال پیام" OnClick="SendButton_OnClickImageButton_Click" />
                               </div>
 	                </div>
                </article>
            </div>
        </div>
    </div>
</asp:Content>

