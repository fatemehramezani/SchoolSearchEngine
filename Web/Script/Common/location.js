function LoadLocation(type) {
    var parentType;
    var defaultValue = -1;
    if (type == 'provience')
        parentType = '';
    else if (type == 'city')
        parentType = 'provience';
    else if (type == 'region')
        parentType = 'city';
    var parentId = $('#' + parentType + 'dropdown').val();
    if (parentType == '')
        parentId = 0;

    $('#locationscontainer').find('input[type=hidden]').each(function (index) {
        var id = $(this).attr('id').toLowerCase();
        var index = id.toString().indexOf(type + 'hiddenfield');
        if (index > -1)
        {
            defaultValue = $(this).val();
        }
    });

    var webMethod = '../../../Service/CommonService.asmx/Locations';
    var parameters = { 'parentId': parentId };
    $.ajax({
        type: "POST",
        url: webMethod,
        data: JSON.stringify(parameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            var p = $('#' + type + 'dropdown');
            if (type == 'provience')
                p.html('<option value=""-1"" selected=""selected"">[انتخاب استان]</option>');
            else if (type == 'city')
                p.html('<option value=""-1"" selected=""selected"">[انتخاب شهر]</option>');
            else if (type == 'region')
                p.html('<option value=""-1"" selected=""selected"">[انتخاب منطقه]</option>');
            $.each(msg.d, function (i, li) {
                var item = $('<option></option>');
                item.text(msg.d[i].Title).attr('value', msg.d[i].Id);
                item.appendTo(p);
            });
            if (defaultValue !== -1) {
                p.val(defaultValue);
                p.change();
            }

            if(p.val() === '')
            {
                if (type == 'provience') {
                    p.val(8);
                    p.change();
                }
                else if (type == 'city')
                {
                    p.val(156);
                    p.change();
                }
                else if (type == 'region') {
                    p.val(1105);
                    p.change();
                }
            }
        },
        error: function (e) {
            console.log(e);
        }
    });
}