$(document).ready(function () {
    var schoolid = $("#SchoolIdHiddenField").val();

    var schooltitle = $("#SchoolNameHiddenField").val();
    var htmlString = $(".schooltitle").html() + schooltitle;
    $(".schooltitle").text(htmlString);

    $("li.menu_item a").each(function (index) {
        var ref = '/'+ schoolid + '/' + $(this).attr('href');
        ref = ref.replace('//', '/');
        $(this).attr('href', ref);
    });
});