$(document).ready(function () {
    $("li.menu_item a").each(function (index) {        
        var schoolid = $("#SchoolIdHiddenField").val();
        var ref = '/'+ schoolid + '/' + $(this).attr('href');
        ref = ref.replace('//', '/');
        $(this).attr('href', ref);
    });
});