;(function(TrackDons){
  var AutoCompleteItemView = Backbone.View.extend({
    tagName: "li",
    className: "autocomplete-item",
    template: _.template('<a href="#"><%= label %></a>'),
    
    events: {
      "click": "select"
    },

    initialize: function(options) {
      this.options = options;
    },

    render: function () {
      this.$el.html(this.template({
        "label": this.model.label()
      }));
      return this;
    },

    select: function () {
      this.options.parent.hide().select(this.model);
      return false;
    }
  });

  TrackDons.Views.AutoComplete = TrackDons.Views.AutoComplete || {};
  TrackDons.Views.AutoComplete.Item = AutoCompleteItemView;

})(TrackDons);


