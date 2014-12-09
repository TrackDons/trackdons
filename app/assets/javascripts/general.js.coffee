$(document).on "page:change", ->
  $(".popup").click (event) ->
    event.preventDefault()
    window.open $(this).attr("href"), "popupWindow", "width=600,height=600,scrollbars=yes"
    return
  $('#donation_project_name').select2
    placeholder: 'Project'
    ajax:
      url: '/projects'
      dataType: 'json'
      quietMillis: 250,
      results: (data, page) ->
        return { results: $.map data, (obj) -> {id: obj.name, text: obj.name} }
      cache: true
      data: (term, page) -> 
        return { q: term }
    # query: (query) ->
    #   data = {results: [{id: 'Wadus', text: 'Wadus'}, {id: 'Wadus 2', text: 'Wadus 2'}]}
    #   query.callback data
    allowClear: 'true'
    createSearchChoice: (term, data) ->
      return {id:term, text: term + ' (Add project)'}
    createSearchChoicePosition: 'bottom'
  $('#donation_project_name').on "select2-selecting", (e) -> 
    if e.choice.text.indexOf('(Add project)') > 0
      $('#project_attributes').slideDown()
    else
      $('#project_attributes').slideUp()
  $('.tipsit').tipsy({fade: true; gravity: 's'})
  my_slidebars = new $.slidebars();
  return


