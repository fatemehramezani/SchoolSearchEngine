<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Item.ascx.cs" Inherits="UserControl_School_Item" %>
<link href="../../App_Themes/Default/css/school.css" rel="stylesheet" />
<script src="../../Script/School/item.js"></script>

<div class="row hentry">
    <div class="col-lg-3 col-md-3 col-sm-4 col-sm-12">
        <h2 class="madreseyab">
            <a href="../<%#Eval("Id") %>" title="مدرسه یاب">مشخصات مدرسه
            </a>
        </h2>
    </div>
    <div class="col-lg-9 col-md-9 col-sm-8 col-sm-12 searchform">
        <div><%# Eval("Features") %></div>
    </div>
</div>

<div class="row hentry">
    <div class="col-lg-3 col-md-3 col-sm-4 col-sm-12">
        <h2 class="madreseyab">
            <a href="../<%#Eval("Id") %>" title="مدرسه یاب">درباره مدرسه
            </a>
        </h2>
    </div>
    <div class="col-lg-9 col-md-9 col-sm-8 col-sm-12 searchform">
        <div><%# Eval("Description") %></div>
    </div>
</div>

<!--<script>
var parser, xmlDoc;
var text = "<bookstore><book>" +
"<title>Everyday Italian</title>" +
"<author>Giada De Laurentiis</author>" +
"<year>2005</year>" +
"</book></bookstore>";

parser = new DOMParser();
xmlDoc = parser.parseFromString(text,"text/xml");

document.getElementById("demo").innerHTML =
xmlDoc.getElementsByTagName("title")[0].childNodes[0].nodeValue + "<br>" +
xmlDoc.getElementsByTagName("author")[0].childNodes[0].nodeValue + "<br>" +
xmlDoc.getElementsByTagName("year")[0].childNodes[0].nodeValue;
</script>-->
