$( "#donation_project_name" ).autocomplete
  source: [ "c++", "java", "php", "coldfusion", "javascript", "asp", "ruby" ]

$(document).on "page:change", ->
  $('.tipsit').tipsy({fade: true; gravity: 's'})
  $.slidebars()
  return
