;(function(context){

  function applySelect2(el, url) {
    $(el).select2({
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
  }

  var Collection = Backbone.Collection.extend();

  var donationView = Backbone.View.extend({
    template: JST['templates/donation'],
    className: 'bb-donation mb3',
    
    events: {
      'change .js-donation-recurring': 'changeRecurringSelect',
      'select2-selecting .js-select2': 'toggleDetails'
    },
    
    initialize: function(options){
      this.path = options.path;

      if (options.el) {
        applySelect2(this.$el.find('.js-select2'), this.path);
      }
    },

    render: function(){
      var html = this.template({
        model: this.model,
        path: this.path
      });

      this.$el.html(html);
      applySelect2(this.$el.find('.js-select2'), this.path);
      return this.$el;
    },
    
    changeRecurringSelect: function(e) {
      var select = $(e.target);
      if (select.val() === "no") {
        this.$el.find('.js-donation-date').html(I18n.t('donation.date'));
      } else {
        this.$el.find('.js-donation-date').html(I18n.t('donation.recurring_date'));
      }
    },

    toggleDetails: function(e) {
      var details = this.$el.find('.js-details');
      if (e.choice.text.indexOf(I18n.t('add_project')) > 0) {
        details.slideDown();
      } else {
        details.slideUp();
      }
    }
  });

  var donationList = Backbone.View.extend({
    events: {
      'click .js-add-donation': 'addModel'
    },

    initialize: function(options){
      this.listenTo(this.collection, 'add', this.addDonation);
      this.listenTo(this.collection, 'remove', this.removeDonation);

      // bind existing views ---> collection
      this.bindStaticViews();
    },

    bindStaticViews: function() {
      var views = this.$el.find('.bb-donation'),
          path = this.$el.attr('data-projects'),
          collection = this.collection;

      _.each(views, function(view){
        var id = new Date().getTime();
        var view = new donationView({el: view, id: id, path: path});
        collection.add({id: id, view: view}, {silent: true});
      });

      $.publish('view:ready');
    },

    addModel: function(e) {
      e && e.preventDefault();

      var id = new Date().getTime(),
          path = this.$el.attr('data-projects');

      var view = new donationView({id: id, path: path});

      this.collection.add({id: id, view: view});
    },

    addDonation: function(model) {
      var view = model.attributes.view;
      this.$el.find('.js-donations').append(view.render());

      $.publish('view:ready');
    },

    removeDonation: function(model) {
      console.log("Removing donation", model);
    }
    
  })
  
  context.TrackDons.Donations = donationList;

  $(function(){
    $('.bb-donations').each(function(dom, element){
      
      var col = new Collection();

      new context.TrackDons.Donations({
        el: element,
        collection: col
      });

    });
  })
})(window);
