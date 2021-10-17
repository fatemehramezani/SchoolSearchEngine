<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Filter.ascx.cs" Inherits="UserControl_School_Filter" %>
<script src="../../Script/School/filter.js"></script>
<div class="row hentry">
    <div class="col-lg-2 col-md-6 col-sm-12 col-xs-12 ">
        <input id="schoolName" maxlength="64" class="form-control ui-autocomplete-input" name="schoolName" placeholder="نام مدرسه" type="text" value="" />
    </div>
    <div class="col-lg-2 col-md-6 col-sm-12 col-xs-12" id="commonscontainer">
        <UserControl:BasicCommons runat="server"/>
    </div>
    <div class="col-lg-6 col-md-6 col-sm-12 col-xs-12">
        <UserControl:Locations runat="server" />
    </div>
    <div class="col-lg-2 col-md-6 col-sm-12 col-xs-12">
        <button type="button" id="btnTeacherAcademySearch" class="btn btn-default btn-sm" style="border: 0px none; width: 100%" onclick="Search();" title="جستجو">
            <img class="img-responsive_" src="App_Themes/Default/images/icon/search.png" alt="جستجو" onclick="Search();"><span>&nbsp;جستجو</span></button>
    </div>
</div>
