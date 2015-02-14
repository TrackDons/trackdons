;(function(TrackDons){

  var AutoCompleteModel = Backbone.Model.extend({
    label: function () {
      return this.get("label");
    }
  });

  TrackDons.Models.AutoComplete = TrackDons.Models.AutoComplete || {};
  TrackDons.Models.AutoComplete.Model = AutoCompleteModel;

})(TrackDons);
    