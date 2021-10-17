<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BasicCommon.ascx.cs" Inherits="UserControl_Common_BasicCommon" %>
<script src="../../../Script/Common/common.js"></script>
<input list="commons<%#parentId %>" name="common<%#parentId %>" id="common<%#parentId %>" class="form-control ui-autocomplete-input" placeholder="[انتخاب مشخصات]">
<datalist id="commons<%#parentId %>">
</datalist>
<input type="submit" hidden="hidden" id="submit_<%#parentId %>">
<input type="hidden" id="parentidhidden<%#parentId %>" value="<%#parentId %>" />
<script>
    Commons('<%#parentId %>');
</script>