;(function(TrackDons){
  
  var model = TrackDons.Models.AutoComplete.Model;
  var AutocompleteCollection = Backbone.Collection.extend({
    model: model
  });

  TrackDons.Collections.AutoComplete = TrackDons.Collections.AutoComplete || {};
  TrackDons.Collections.AutoComplete.Collection = AutocompleteCollection;

})(TrackDons);
