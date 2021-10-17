function Search()
{
    var url = 'search/';

    var region = parseInt($('#regiondropdown').val());
    if (region != null && region != -1 && !isNaN(region))
        url = url + '&region=' + region;
    else
    {
        var city = parseInt($('#citydropdown').val());
        if (city != null && city != -1 && !isNaN(city))
            url = url + '&city=' + city;
        else
        {
            var provience = parseInt($('#proviencedropdown').val());
            if (provience != null && provience != -1 && !isNaN(provience))
                url = url + '&provience=' + provience;
        }
    }

    var name = decodeURIComponent($('#schoolName').val());
    if (name != null && name.length > 0)
        url = url + '&name=' +'مدرسه-'+ name.replace(' ','-');    

    var g = $.trim($('#common').val());
    var filterid = parseInt($('#commons').find('option').filter(function () { return $.trim($(this).text()) === g; }).attr('data-id'));
    if (filterid != null && filterid != -1 && !isNaN(filterid))
        url = url + '&filterid=' + filterid;

    if( url != 'search/')
        window.location = url.replace('/&','/');
}