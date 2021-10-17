function Commons(parentId) {
    var webMethod = '../../../Service/CommonService.asmx/Commons';
    if (parentId === '')
        parentId = '-1';
    var parameters = { 'parentId': parentId };
    var defaultValue = -1;
    var type = '';
    if (parentId === '2')
        type = 'gender';
    else if (parentId === '3')
        type = 'section';
    else if (parentId === '1')
        type = 'type';
    $('#commonscontainer').find('input[type=hidden]').each(function (index) {
        var id = $(this).attr('id').toLowerCase();
        if (type != '') {
            var index = id.toString().indexOf(type + 'hiddenfield');
            if (index > -1) {
                defaultValue = $(this).val();
            }
        }
    });
    $.ajax({
        type: "POST",
        url: webMethod,
        data: JSON.stringify(parameters),
        contentType: "application/json; charset=utf-8",
        dataType: "json",
        success: function (msg) {
            var p;
            if (parentId != '-1')
                p = $('#commons' + parentId);
            else
                p = $('#commons');
            if (type === 'gender')
                p.html('<option value=""-1"" selected=""selected"">[انتخاب جنسیت]</option>');
            else if (type === 'section')
                p.html('<option value=""-1"" selected=""selected"">[انتخاب مقطع]</option>');
            else if (type === 'type')
                p.html('<option value=""-1"" selected=""selected"">[انتخاب نوع مدرسه]</option>');
            else if (type === '')
                p.html('<option value=""-1"" selected=""selected"">[انتخاب مشخصات]</option>');
            $.each(msg.d, function (i, li) {
                var item = $('<option>');
                item.text(msg.d[i].Title).attr('value', msg.d[i].Title).attr('data-id', msg.d[i].Id);
                item.appendTo(p);
            });
            if (defaultValue !== '-1') {
                p.val(defaultValue);
                p.change();
            }
        },
        error: function (e) {
            console.log(e);
        }
    })
}
