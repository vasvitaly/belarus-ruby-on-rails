$(document).ready(function() {
    $(".answer_choise").change(function() {
        if ($(this).find("option[value='true']").attr('selected')) {
            addTextArea($(this).attr('name'), $(this).attr('id'), $('.answer_hint').attr('label'));
        }
        else {
            dellTextArea($(this).attr('id'))
        }
    });
});

function addTextArea(name, id, hint) {
    $('.answer_choise').parent().append("<br />");
    $('.answer_choise').parent().append("<text type='text', value='"+hint+"'></text>" );
    $('.answer_choise').parent().append("<textarea type='textarea' cols='40' rows='5' id='"+id+"_textarea' name='"+name+"' " + "'></textarea>");
}

function dellTextArea(id) {
    $("#"+id+"_textarea").remove()
    $('br').remove()
}