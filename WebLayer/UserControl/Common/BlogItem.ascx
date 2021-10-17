<%@ Control Language="C#" AutoEventWireup="true" Inherits="UserControl_Common_BlogItem" Codebehind="BlogItem.ascx.cs" %>
<article class="post hentry format-image">
    <header class="entry-header">
        <h1 class="entry-title"><%# Eval("Title")%></h1>
        <div class="entry-meta">
            <div class="entry-format">
                <span class="image-format">image</span>
            </div>
            <span class="sep">| </span>
            <time class="entry-date"><%#Utility.PersianDateConvertor.ToPersianDate((DateTime)Eval("Date"),"yyyy/MM/dd")%></time>
            <span class="sep">| </span>
            <span class="cat-links"><a runat="server" href='<%#Utility.Common.GetConfigValue("BlogFileUrl")+"/"+ Eval("FileUrl") %>'>دانلود فایل</a></span>
            <span class="sep">| </span>
        </div>
    </header>
    <div class="entry-content">
        <div class="full-size">
            <img runat="server" src='<%#Utility.Common.GetConfigValue("BlogImageUrl")+"/"+Eval("ImageUrl") %>' alt='<%# Eval("ImageUrl") %>'>
        </div>
        <decription>
            <p><%# Eval("Description") %></p>
        </decription>
    </div>
</article>
