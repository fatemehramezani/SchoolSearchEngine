$(document).ready(function () {
    $("name:first-of-type").before("<h3><i class='glyphicon glyphicon-education normal'/>&nbsp;نام مدرسه:</h3>");
    $("manager:first-of-type").before("<h3><i class='glyphicon glyphicon-certificate normal'/>&nbsp;مدیر مدرسه:</h3>");
    $("founder:first-of-type").before("<h3><i class='glyphicon glyphicon-flag normal'/>&nbsp;موسس مدرسه:</h3>");
    $("phone:first-of-type").before("<h3><i class='glyphicon glyphicon-phone normal'/>&nbsp;شماره تلفن مدرسه:</h3>");
    $("phone:not(:last)").after("،");
    $("address:first-of-type").before("<h3><i class='glyphicon glyphicon-map-marker normal'/>&nbsp;آدرس دقیق مدرسه:</h3>");
    var htmlString = $("province").html() + "،" + $("city").html() + "،" + $("region").html() + "،" + $("address").html();
    $("address").text(htmlString);
});