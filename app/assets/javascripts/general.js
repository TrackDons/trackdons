;$(function(e){
  $(".popup").click(function(e){
    e.preventDefault();
    window.open($(this).attr("href"), "popupWindow", "width=600,height=600,scrollbars=yes");
  });
    
  $('.js-select2').each(function(){
    var $this = $(this),
        url = $this.data('projects-url');

    $this.select2({
      placeholder: I18n.t('project'),
      ajax: {
        url: url,
        dataType: 'json',
        quietMillis: 250,
        results: function(data, page){
            return { 
              results: $.map(data, function(obj){
                return {id: obj.name, text: obj.name};
              })
            }
        },
        cache: true,
        data: function(term, page){
          return {q: term};
        }
      },
      allowClear: 'true',
      createSearchChoice: function(term, data){
        return {id:term, text: term + ' ' + I18n.t('add_project')}
      },
      createSearchChoicePosition: 'bottom'
    });
  });

  $('#donation_project_attributes_name').on("select2-selecting", function(e){
    if (e.choice.text.indexOf(I18n.t('add_project')) > 0) {
      $('#project_attributes').slideDown();
    } else {
      $('#project_attributes').slideUp();
    }
  });
    
  $('.tipsit').tipsy({fade: true, gravity: 's'});
  $.slidebars();

  I18n.defaultLocale = "<%= I18n.default_locale %>";
  I18n.locale = "<%= I18n.locale %>";

});

