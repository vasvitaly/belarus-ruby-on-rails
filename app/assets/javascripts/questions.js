    $(".answer_choise").change(function() {
        if ($(this).find("option[value='true']").attr('selected')) {
            addTextArea($(this).attr('name'), $(this).attr('id'));
        }
        else {
            dellTextArea($(this).attr('id'));
        }
});

function addTextArea(name, id) {
    $('#'+id).parent().append("<br />");
    $('#'+id).parent().append("<textarea type='textarea' cols='40' rows='5' id='"+id+"_textarea' name='"+name+"' " + "'></textarea>");
}

function dellTextArea(id) {
    $("#"+id+"_textarea").remove();
    $('br').remove();
}
