<%@ Control Language="C#" AutoEventWireup="true" Inherits="UserControl_School_Filter" Codebehind="Filter.ascx.cs" %>
<div class="row hentry" style="direction: rtl; float: right;">
    <div class="col-lg-9 col-md-7 col-sm-12 searchform">
        <div class="row col-lg-3 col-md-6 col-sm-12 ">
            <input id="facilityName" class="form-control ui-autocomplete-input" maxlength="64" name="facilityName" placeholder="امکانات مدرسه" type="text" value="" />
        </div>
        <div class="row col-lg-3 col-md-6 col-sm-12 ">
            <input id="schoolName" maxlength="64" class="form-control ui-autocomplete-input" name="schoolName" placeholder="نام مدرسه" type="text" value="" />
        </div>
        <div class="row col-lg-3 col-md-6 col-sm-12 ">
            <input id="provienceName" maxlength="64" class="form-control ui-autocomplete-input" name="provienceName" placeholder="استان مدرسه" type="text" value="" />
        </div>
        <div class="row col-lg-3 col-md-6 col-sm-12 ">
            <input id="cityName" maxlength="64" class="form-control ui-autocomplete-input" name="cityName" placeholder="شهر مدرسه" type="text" value="" />
        </div>

        <div class="row col-lg-3 col-md-6 col-sm-12 margin20">
            <button type="button" id="btnTeacherAcademySearch" class="btn btn-default btn-sm" style="border: 0px none; width: 100%" onclick="TeacherAcademySearch();" title="جستجو">
                <img class="img-responsive_" src="App_Themes/Default/images/icon/search.png" alt="جستجو" onclick="TeacherAcademySearch();"><span>&nbsp;جستجو</span></button>
        </div>
        <div class="row col-lg-3 col-md-6 col-sm-12 margin20">
        </div>
        <div class="row col-lg-3 col-md-6 col-sm-12 ">
            <input id="areaName" maxlength="64" class="form-control ui-autocomplete-input" name="areaName" placeholder="منطقه مدرسه" type="text" value="" />
        </div>
        <div class="row col-lg-3 col-md-6 col-sm-12 ">
            <select name="gender" id="gender" class="form-control dropdown">
                <option selected="selected" value="">جنسیت</option>
                <option value="0">دخترانه</option>
                <option value="1">پسرانه</option>
                <option value="2">دخترانه/پسرانه</option>
            </select>
        </div>
    </div>
    <div class="col-lg-3 col-md-5 col-sm-12">
        <h2 class="madreseyab">
            <a href="http://www.madreseyab.com" title="مدرسه یاب">جستجوی مدرسه
            </a>
        </h2>
    </div>
</div>
