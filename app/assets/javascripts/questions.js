    $(".answer_choise").change(function() {
        if ($(this).find("option[value='true']").attr('selected')) {
            addTextArea($(this).attr('name'), $(this).attr('id'));
        }
        else {
            dellTextArea($(this).attr('id'));
        }
});

function addTextArea(name, id) {
    var hint = $('.hint').text();
    $('#'+id).parent().append("<br />");
    $('#'+id).parent().append("<textarea type='textarea' cols='40' rows='5' id='"+id+"_textarea' name='"+name+"' " + "' placeholder='"+hint+"' ></textarea>");
}

function dellTextArea(id) {
    $("#"+id+"_textarea").remove();
    $('br').remove();
}

$('#participation').submit(function(event) {
  var $submit = $(this).find("button");
  $submit.addClass("gray");
  $submit.attr("disabled", "disabled");
})