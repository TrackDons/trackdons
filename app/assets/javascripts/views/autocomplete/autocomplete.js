;(function(TrackDons){

  var AutoCompleteView = Backbone.View.extend({
    tagName: "ul",
    className: "autocomplete",
    wait: 100,

    queryParameter: "query",
    minKeywordLength: 1,
    currentText: "",
    itemView: TrackDons.Views.AutoComplete.Item,

    initialize: function (options) {
      _.extend(this, options);
      this.filter = _.debounce(this.filter, this.wait);
      $(document).on('click', _.bind(this.hide, this));
    },

    render: function () {
      // disable the native auto complete functionality
      this.input.attr("autocomplete", "off");

      this.input
      .keyup(_.bind(this.keyup, this))
      .keydown(_.bind(this.keydown, this))
      .after(this.$el);

      return this;
    },

    keydown: function (event) {
      if (event.keyCode == 38) return this.move(-1);
      if (event.keyCode == 40) return this.move(+1);
      if (event.keyCode == 13) return this.onEnter();
      if (event.keyCode == 27) return this.hide();
    },

    blur: function() {
      this.hide();
    },

    keyup: function () {
      var keyword = this.input.val();

      if (this.isChanged(keyword)) {
        if (this.isValid(keyword)) {
          this.filter(keyword);
        } else {
          this.hide();
        }
        this.currentText = keyword;
      }
    },

    filter: function (keyword) {
      var keyword = keyword.toLowerCase();
      if (this.collection.url) {
        var parameters = {};
        parameters[this.queryParameter] = keyword;

        this.collection.fetch({
          success: _.bind(function () {
            this.loadResult(this.collection.models, keyword);
          }, this),
          data: parameters,
          cache: (typeof this.collection.cache != 'undefined') ? this.collection.cache : undefined,
          dataType: (this.collection.datatype) ? this.collection.datatype : undefined,
          jsonpCallback: (this.collection.callback) ? this.collection.callback : undefined
        });

      } else {
        this.loadResult(this.collection.filter(function (model) {
          return model.label().toLowerCase().indexOf(keyword) !== -1
        }), keyword);
      }
    },

    isValid: function (keyword) {
      return keyword.length >= this.minKeywordLength
    },

    isChanged: function (keyword) {
      return this.currentText != keyword;
    },

    move: function (position) {
      var current = this.$el.children(".is-active"),
          siblings = this.$el.children(),
          index = current.index() + position;

      if (index < 0) {
        return false;
      }

      if (siblings.eq(index).length) {
        current.removeClass("is-active");
        siblings.eq(index).addClass("is-active");
      }

      this.ensureHighlightVisible();
      
      return false;
    },

    highlight: function() {
      var current = this.$el.children(".is-active"),
          index = 0;
      return current.index();
    },

    ensureHighlightVisible: function () {
        var results = this.$el, children, index, child, hb, rb, y, more, topOffset;

        index = this.highlight();
        if (index < 0) return;

        if (index == 0) {
            results.scrollTop(0);
            return;
        }

        children = this.$el.children();
        child = $(children[index]);
        topOffset = (child.offset() || {}).top || 0;
        hb = topOffset + child.outerHeight(true);
        rb = results.offset().top + results.outerHeight(false);

        if (hb > rb) {
          results.scrollTop(results.scrollTop() + (hb - rb));
        }

        y = topOffset - results.offset().top;

        if (y < 0) {
          results.scrollTop(results.scrollTop() + y); // y is negative
        }
    },

    onEnter: function () {
      this.$el.children(".is-active").click();
      return false;
    },

    loadResult: function (collection, keyword) {
      this.show().reset();
      if (collection.length) {
        _.forEach(collection, this.addItem, this);
        this.show();
      } else {
        this.hide();
      }
    },

    addItem: function (model) {
      this.$el.append(new this.itemView({
        model: model,
        parent: this
      }).render().$el);
    },

    select: function (model) {
      var label = model.label();
      this.input.val(label);
      this.currentText = label;
      this.onSelect(model);
    },

    reset: function () {
      this.$el.empty();
      return this;
    },

    hide: function () {
      this.$el.hide();
      return this;
    },

    show: function () {
      this.$el.show();
      return this;
    },

    // callback definitions
    onSelect: function () {}
  });

  TrackDons.Views.AutoComplete = TrackDons.Views.AutoComplete || {};
  TrackDons.Views.AutoComplete.Component = AutoCompleteView;

})(TrackDons);
