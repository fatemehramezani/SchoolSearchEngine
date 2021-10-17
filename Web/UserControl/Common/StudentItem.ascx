<%@ Control Language="C#" AutoEventWireup="true" CodeFile="StudentItem.ascx.cs" Inherits="UserControl_Common_StudentItem" %>
<article class="post hentry format-image">
    <header class="entry-header">
        <h1 class="entry-title"><%# Eval("Title")%> <%# Eval("FirstName")%> <%# Eval("LastName")%></h1>
        <div class="entry-meta">
            <div class="entry-format">
                <span class="image-format">image</span>
            </div>
            <span class="sep">| </span>
        </div>
    </header>
    <div class="entry-content">
        <div class="full-size">
            <img runat="server" src='<%#Utility.Common.GetConfigValue(Utility.Common.StudentAvatarUrl)+"/"+Eval("SchoolId")+"/"+ Eval("AvatarUrl") %>' alt='<%# Eval("AvatarUrl") %>'>
        </div>
        <decription>
            <p><%# Eval("Description") %></p>
        </decription>
    </div>
</article>
