<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Location.ascx.cs" Inherits="UserControl_Common_Location" %>
<script src="../../../Script/Common/location.js"></script>
<div class="col-lg-4 col-md-4 col-xs-12">
    <select name="proviencedropdown" id="proviencedropdown" class="form-control dropdown" onchange="LoadLocation('city');">
        <option value="-1" selected="selected">[انتخاب استان]</option>
    </select>
</div>
<div class="col-lg-4 col-md-4 col-xs-12">
    <select name="citydropdown" id="citydropdown" class="form-control dropdown" onchange="LoadLocation('region');">
        <option value="-1" selected="selected">[انتخاب شهر]</option>
    </select>
</div>
<div class="col-lg-4 col-md-4 col-xs-12">
    <select name="regiondropdown" id="regiondropdown" class="form-control dropdown">
        <option value="-1" selected="selected">[انتخاب منطقه]</option>
    </select>
</div>
<script>
    LoadLocation('provience');
</script>