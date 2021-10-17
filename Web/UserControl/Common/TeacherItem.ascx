<%@ Control Language="C#" AutoEventWireup="true" CodeFile="TeacherItem.ascx.cs" Inherits="UserControl_Common_TeacherItem" %>
<article class="post hentry format-image">
    <header class="entry-header">
        <h1 class="entry-title"><%# Eval("Title")%> <%# Eval("FirstName")%> <%# Eval("LastName")%></h1>
        <div class="entry-meta">
            <div class="entry-format">
                <span class="image-format">عکس</span>
            </div>
            <span class="sep">| </span>
            <span class="cat-links"><a runat="server" href='<%#Utility.Common.GetConfigValue(Utility.Common.TeacherResumeUrl)+"/"+Eval("SchoolId")+"/"+ Eval("ResumeUrl") %>'>مشاهده رزومه</a></span>
            <span class="sep">| </span>
        </div>
    </header>
    <div class="entry-content">
        <div class="full-size">
            <img runat="server" src='<%#Utility.Common.GetConfigValue(Utility.Common.TeacherAvatarUrl)+"/"+Eval("SchoolId")+"/"+ Eval("AvatarUrl") %>' alt='<%# Eval("AvatarUrl") %>'>
        </div>
        <decription>
            <p><%# Eval("Description") %></p>
        </decription>
    </div>
</article>
