# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
project_name = new String()
$(document).on "page:change", ->
  
  $('#donation_project_name').on 'keyup', ->
    project_name = $(this).val()
  
  $('#donation_project_name').bind 'railsAutocomplete.select', (event, data) =>
    if data.item.id is ''
      window.location = '/projects/new?name=' + project_name
