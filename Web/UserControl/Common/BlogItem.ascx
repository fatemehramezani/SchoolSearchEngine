<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BlogItem.ascx.cs" Inherits="UserControl_Common_BlogItem" %>
<article class="post hentry format-image">
    <header class="entry-header">
        <h1 class="entry-title"><%# Eval("Title")%></h1>
        <div class="entry-meta">
            <div class="entry-format">
                <span class="image-format">عکس</span>
            </div>
            <span class="sep">| </span>
            <time class="entry-date"><%#Utility.PersianDateConvertor.ToPersianDate((DateTime)Eval("Date"),"yyyy/MM/dd")%></time>
            <span class="sep">| </span>
            <span class="cat-links"><a runat="server" href='<%#Utility.Common.GetConfigValue(Utility.Common.BlogFileUrl)+"/"+Eval("SchoolId")+"/"+ Eval("FileUrl") %>'>دانلود فایل</a></span>
            <span class="sep">| </span>
        </div>
    </header>
    <div class="entry-content">
        <div class="full-size">
            <img runat="server" src='<%#Utility.Common.GetConfigValue(Utility.Common.BlogImageUrl)+"/"+Eval("SchoolId")+"/"+ Eval("ImageUrl") %>' onerror="this.src='../../../Files/NoImage.png'" alt='<%# Eval("ImageUrl") %>'>
        </div>
        <decription>
            <p><%# Eval("Description") %></p>
        </decription>
    </div>
</article>
