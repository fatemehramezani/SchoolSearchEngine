<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" Inherits="Default" Codebehind="Default.aspx.cs" %>
<%@ Register Src="~/UserControl/School/Filter.ascx" TagName="SchoolFilter" TagPrefix="UserControl" %>
<%@ Register Src="~/UserControl/Common/DynamicPage.ascx" TagName="DynamicPage" TagPrefix="UserControl" %>
<%--<%@ OutputCache Duration="10" VaryByParam="None" %>--%>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
    <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery.matchHeight/0.7.0/jquery.matchHeight-min.js"></script>
    <script src="Script/Common/default.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopContent" runat="Server">
    <div class="row">
        <!-- Category -->
        <div class="col-lg-2 col-md-3 col-sm-12 col-xs-12">
            <ul class="filtertab box">
                <li id="tuition" tooltip="میزان شهریه">
                    <h2>میزان شهریه</h2>
                </li>
                <li id="girl">
                    <h2>مدارس دخترانه</h2>
                </li>
                <li id="boy">
                    <h2>مدارس پسرانه
                    </h2>
                </li>
                <li id="first">
                    <h2>دوره اول
                    </h2>
                </li>
                <li id="second">
                    <h2>دوره دوم
                    </h2>
                </li>
            </ul>
        </div>
        <!-- TOP SLIDER -->
        <div class="col-lg-10 col-md-9 hidden-sm hidden-xs">
            <section id="home" class="padbot0 box">
                               <div class="flexslider top_slider">
                                <ul class="slides">
                                      <li class="slide1">
                                        <div class="flex_caption1">
                                          <p class="title1 captionDelay2 FromTop">انتخاب</p>
                                          <p class="title2 captionDelay4 FromTop">هوشمندانه</p>
                                          <p class="title2 captionDelay4 FromBottom">همراه با آگاهی</p>
                                          <p class="title4 captionDelay7 FromBottom">تحقیق و جستجوی آگاهانه درباره مدرسه دختران و پسرانمان</p>
                                        </div>
                                       </li>
                                        <li class="slide2">
                                          <div class="flex_caption1">
                                            <p class="title2 captionDelay2 FromLeft">آینده</p>
                                            <p class="title1 captionDelay3 FromLeft">موفق</p>
                                            <p class="title3 captionDelay4 FromLeft">تحصیلی</p>
                                            <p class="title4 captionDelay5 FromLeft">بهترین مدارس کشور</p>
                                          </div>
                                        </li>
                                        <li class="slide3">
                                          <div class="flex_caption1">
                                            <p class="title1 captionDelay1 FromBottom">مقایسه امکانات مدارس</p>
                                            <p class="title2 captionDelay2 FromBottom">هوشمند سازی</p>
                                            <p class="title3 captionDelay3 FromBottom">امکانات ورزشی</p>
                                            <p class="title4 captionDelay5 FromBottom">مشاهده امکانات و تجهیزات مدرسه</p>
                                          </div>
                                        </li>
                                    </ul>
                                      </div>
                               <div id="carousel">
                                   <ul class="slides hidden-lg hidden-md hidden-sm" runat="server" id="slider">                                          
                                    </ul>
                               </div>
                                      <!-- //TOP SLIDER -->
                             </section>
        </div>
    </div>
    <UserControl:SchoolFilter runat="server" />
    <div class="row hentry">
        <header class="entry-header">
                                  <h1 class="entry-title">
                                      <a href="مدرسه_یاب">
                                        <UserControl:DynamicPage ID="DefaultH1" runat="server" Name="DefaultH1"/>
                                      </a>
                                  </h1>
                                </header>
    </div>
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="Server">
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomContent" runat="Server">
    <div class="row hentry">
        <UserControl:DynamicPage runat="server" Name="DefaultDescription" />
    </div>
</asp:Content>

