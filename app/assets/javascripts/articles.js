//ask admin if he really want to leave page
$(document).ready(function(){
  var submit = false;

  var data = '';
  $.each(CKEDITOR.instances, function(name, el){
    data += el.getData();
  });
  var state = $(".forms form").serialize() + data;

  $(".forms form").data("state", state);

  $(window).bind("beforeunload",function(e) {
    data = '';
    $.each(CKEDITOR.instances, function(name, el){
      data += el.getData();
    });
    state = $(".forms form").serialize() + data;

    if(!submit && $(".forms form").data("state") != state) {
      e.returnValue = I18n.t('articles.form_changed');
      return I18n.t('articles.form_changed');
    }
  });

  $(".forms form").submit(function() {
    submit = true;
  });
});

function update_edit_article_action() {
    jQuery('.edit_article input[name="_method"]').val('delete');
}
