$( "#donation_project_name" ).autocomplete
  source: [ "c++", "java", "php", "coldfusion", "javascript", "asp", "ruby" ]

$(document).on "page:change", ->
  $(".popup").click (event) ->
    event.preventDefault()
    window.open $(this).attr("href"), "popupWindow", "width=600,height=600,scrollbars=yes"
    return
  $('.tipsit').tipsy({fade: true; gravity: 's'})
  my_slidebars = new $.slidebars();
  return


