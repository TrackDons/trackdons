# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).on "page:change", ->
  $('#i_want_to_explain_content textarea').focus()
  $("#i_want_to_explain").on "click", ->
    $('#i_want_to_explain_content').animate({height: 'toggle', opacity: "toggle", "easein"}, 500)
    $('#i_want_to_explain_content textarea').focus()
