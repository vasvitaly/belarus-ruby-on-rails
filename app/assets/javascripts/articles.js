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

//support drafts
var article_drafts_timer;
$(document).ready(function(){
  //create new article to have id for object_id field
  if($(".forms form").hasClass("new_article")) {
    $.ajax({
      url: "/admin/articles.json",
      type: "POST",
      dataType: "json",
      data: {article: {title: "new article", content: "&nbsp;", published: false}}
    }).done(function(article){
      $(".forms form").attr("action", $(".forms form").attr("action") + "/" + article.id);
      $(".forms form").append("<input type='hidden' value='put' name='_method'>");
      get_article_drafts();
    });
  } else {
    get_article_drafts();
  }
  //set timer to make first draft in 10 minutes
  article_drafts_timer = setTimeout(create_article_draft, 5*60*1000);
});

function get_article_drafts() {
  //get article id from action attribute
  var article_id = parseInt($(".forms form").attr("action").split("/").slice(-1)[0]);
  //get drafts for this article
  $.ajax({
    url: "/drafts.json",
    dataType: "json",
    data: {object_id: article_id, object_type: "article"}
  }).done(function(data) {
    $.each(data, function(i, draft){
      $("#drafts").prepend("<option value='"+draft.id+"'>"+draft.created_at+"</option>");
      $("#drafts option[value='"+draft.id+"']").data("draft_object", $.parseJSON(draft.draft_object));
    });
  });
}

function create_article_draft() {
  //update values in fields that was replaced by ckeditor
  for(var instanceName in CKEDITOR.instances)
    CKEDITOR.instances[instanceName].updateElement();
  //collect all values to draft_object
  var elements = $(".forms form").find("textarea, select, input").not("input[type='hidden'], #drafts");
  var draft_object = [];
  $.each(elements, function(i, element){
    draft_object.push({name: $(element).attr("name"), value: $(element).val()});
  });
  //get article id from action attribute
  var article_id = parseInt($(".forms form").attr("action").split("/").slice(-1)[0]);
  //save draft in database
  $.ajax({
    url: "/drafts.json",
    type: "POST",
    dataType: "json",
    data: {object_id: article_id, object_type: "article", draft_object: JSON.stringify(draft_object)}
  }).done(function(draft){
    //update list of drafts
    $("#drafts").prepend("<option value='"+draft.id+"'>"+draft.created_at+"</option>");
      $("#drafts option[value='"+draft.id+"']").data("draft_object", draft_object);
  });
  //set timer to make next draft in 10 minutes
  article_drafts_timer = setTimeout(create_article_draft, 10*60*1000);
}

function restore_article_draft(id) {
  if(!(id > 0)) return;
  var draft_object = $("#drafts option[value='"+id+"']").data("draft_object");
  $.each(draft_object, function(i, draft_item){
    var element = $(".forms form [name='"+draft_item.name+"']");
    var element_id = $(element).attr("id");
    if(typeof CKEDITOR.instances[element_id] != 'undefined') {
      CKEDITOR.instances[element_id].setData(draft_item.value);
    }
    $(element).val(draft_item.value);
  });
}

function update_edit_article_action() {
    jQuery('.edit_article input[name="_method"]').val('delete');
}
