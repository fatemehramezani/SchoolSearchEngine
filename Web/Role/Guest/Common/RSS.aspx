<%@ Page Title="" Language="C#" MasterPageFile="~/App_MasterPage/DefaultMasterPage.master" AutoEventWireup="true" CodeFile="RSS.aspx.cs" Inherits="Role_Guest_Common_RSS" %>
<asp:Content ID="Content1" ContentPlaceHolderID="HeadContent" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="TitleContent" runat="Server">
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="TopContent" runat="Server">
</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="tab-pane fade in container-fluid ">
        <label style="color: red;">آخرین اخبار مربوط به مدارس</label>
        <br />
        <div class="jumbotron">
            <h1>            
            <b>
                بازدید کننده گرامی
            </b>
                <br />
                اخبار مرتبط با مدرسه ها و مدارس دولتی، غیر دولتی، نمونه مردمی، مردمی،، هیات امنایی، غیرانتفاعی و سایر مدارس در ادامه آورده شده است.
            لیست آخرین اخبار مرتبط با آموزش و پرورش نیز در ادامه آورده شده است. شما می توانید با استفاده از لینک مربوط به هر خبر به مرجع خبر مراجعه نمایید و جزئیات بیشتر خبر را از مرجع اصلی مطالعه نمایید
                </h1>
        </div>
        <div class="row-fluid">
            <asp:Repeater ID="RssRepeater" runat="server" EnableViewState="false">
                <ItemTemplate>
                    <article class="col-lg-12 col-md-12 col-sm-12 col-xs-12">
                        <hr />
                        <div class="container-fluid boxinfo">
                            <div class="row">
                                <div class="col-md-12 col-sm-12 col-xs-12">
                                    <div data-type="title">عنوان خبر: <a href="<%#Eval("Link") %>" title="<%# Eval("Title")%>"><%# Eval("Title")%> </a></div>
                                    <div data-type="publishdate">تاریخ انتشار خبر: <%#Eval("PublishDate")%></div>
                                    <div data-type="description">
                                        <div class="container-fluid"><%#Eval("Description")%></div>
                                    </div>
                                    <div data-type="link">
                                        <a href="<%#Eval("Link") %>">
                                            <i class="icon-eye-open"></i>مطالعه و اطلاعات بیشتر
                                        </a>
                                    </div>
                                    <hr />
                                    <UserControl:Keyword runat="server" />
                                </div>
                            </div>
                        </div>
                    </article>
                </ItemTemplate>
            </asp:Repeater>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content5" ContentPlaceHolderID="BottomContent" runat="Server">
</asp:Content>

