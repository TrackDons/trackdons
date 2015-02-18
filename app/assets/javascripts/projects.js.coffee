$(document).on "page:change", ->
  $('#project_name').on "keyup", ->
    value = $(this).val()
    if value.length > 2
      value = value.trim()
      $.ajax({
        dataType: "json",
        url: $('#project_name').data('projects-url'),
        data: {q: value},
        error: (jqXHR, textStatus, errorThrown) ->
          $('body').append "AJAX Error: #{textStatus}"
        success: (data, textStatus, jqXHR) ->
          if data.length == 1 and data[0].name == value
            $('form *').attr('disabled', 'disabled')
            $('#project_name').attr('disabled', null)
            p = $('p[data-existing-project-error]')
            a = $('<a href="'+data[0].project_url+'">' + p.attr('data-existing-project-error') + '</a>')
            p.html(a)
          else
            $('form *').attr('disabled', null)
            $('p[data-existing-project-error]').html('')
      })
  $('#country').on "change", ->
    window.location.href = $(this).val()
