$(document).on "page:change", ->
  $('#project_name').on "keyup", ->
    value = $(this).val()
    if value.length > 2
      value = value.trim()
      $.ajax({
        dataType: "json",
        url: '/projects',
        data: {q: value},
        error: (jqXHR, textStatus, errorThrown) ->
          $('body').append "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) ->
          if data.length == 1 and data[0].name == value
            $('form *').attr('disabled', 'disabled')
            $('#project_name').attr('disabled', null)
            p = $('p[data-existing-project-error]')
            p.html(p.attr('data-existing-project-error'))
          else
            $('form *').attr('disabled', null)
            $('p[data-existing-project-error]').html('')
      })

