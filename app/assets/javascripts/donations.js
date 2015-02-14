;$(function(e){
  $('#i_want_to_explain_content textarea').focus();

  $("#i_want_to_explain").on("click", function(e){
    $('#i_want_to_explain_content').animate({
      height: 'toggle', 
      opacity: "toggle"
    }, 500, "easein");
    $('#i_want_to_explain_content textarea').focus();
  });

  if ($('#i_want_to_explain').attr('checked') === 'checked'){
    $('#i_want_to_explain_content').show();
  }
});