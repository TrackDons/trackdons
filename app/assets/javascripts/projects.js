;$(function(e){
  $('#project_name').on("keyup", function(e){
    var value, p, a;

    value = $(this).val();
    if (value.length > 2) {
      value = value.trim()
      $.ajax({
        dataType: "json",
        url: $('#project_name').data('projects-url'),
        data: {q: value},
        error: function(jqXHR, textStatus, errorThrown){
          $('body').append("AJAX Error: #{textStatus}");
        },
        success: function(data, textStatus, jqXHR){
          if (data.length == 1 && data[0].name == value){
            $('form *').attr('disabled', 'disabled');
            $('#project_name').attr('disabled', null);
            p = $('p[data-existing-project-error]');
            a = $('<a href="'+data[0].project_url+'">' + p.attr('data-existing-project-error') + '</a>');
            p.html(a);
          } else {
            $('form *').attr('disabled', null);
            $('p[data-existing-project-error]').html('');
          }
        }
      });
    }
  });
});
