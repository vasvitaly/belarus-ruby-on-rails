$(document).ready(function(){
  $(".tryout").click(function(){
    var button = $(this);
    var data = {};
    $.each($(button).closest("form").find("select, input, textarea").not('[type="hidden"]'), function(i, e){
      if($(e)[0].tagName == "TEXTAREA") {
        if(typeof CKEDITOR.instances[$(e)[0].id] != "undefined") {
          data[$(e)[0].name] = CKEDITOR.instances[$(e)[0].id].getData();
        } else {
          data[$(e)[0].name] = $(e).text();
        }
      } else {
        data[$(e)[0].name] = $(e).val();
      }
    });
    $.ajax({
      type: "POST",
      url: $(button).attr("data-url"),
      data: data
    });
  });
});
