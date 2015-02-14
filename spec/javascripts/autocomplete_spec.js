describe('AutoComplete', function() {

  it('should be defined', function() {
    expect(TrackDons.Views.AutoComplete.Component).toBeDefined();
  });

  describe('functionality', function() {
    
    var states, $input, collection, view, Component;

    beforeEach(function () {
      loadFixtures('autocomplete_fixture.html');

      states = [
        {"label": "Alabama"},
        {"label": "Alaska"},
        {"label": "American Samoa"},
        {"label": "Arizona"},
        {"label": "Arkansas"},
        {"label": "California"},
        {"label": "Colorado"},
        {"label": "Connecticut"},
        {"label": "Delaware"},
        {"label": "District Of Columbia"},
        {"label": "Federated States Of Micronesia"},
        {"label": "Florida"},
        {"label": "Georgia"},
        {"label": "Guam"},
        {"label": "Hawaii"},
        {"label": "Idaho"},
        {"label": "Illinois"},
        {"label": "Indiana"},
        {"label": "Iowa"},
        {"label": "Kansas"},
        {"label": "Kentucky"},
        {"label": "Louisiana"},
        {"label": "Maine"},
        {"label": "Marshall Islands"},
        {"label": "Maryland"},
        {"label": "Massachusetts"},
        {"label": "Michigan"},
        {"label": "Minnesota"},
        {"label": "Mississippi"},
        {"label": "Missouri"},
        {"label": "Montana"},
        {"label": "Nebraska"},
        {"label": "Nevada"},
        {"label": "New Hampshire"},
        {"label": "New Jersey"},
        {"label": "New Mexico"},
        {"label": "New York"},
        {"label": "North Carolina"},
        {"label": "North Dakota"},
        {"label": "Northern Mariana Islands"},
        {"label": "Ohio"},
        {"label": "Oklahoma"},
        {"label": "Oregon"},
        {"label": "Palau"},
        {"label": "Pennsylvania"},
        {"label": "Puerto Rico"},
        {"label": "Rhode Island"},
        {"label": "South Carolina"},
        {"label": "South Dakota"},
        {"label": "Tennessee"},
        {"label": "Texas"},
        {"label": "Utah"},
        {"label": "Vermont"},
        {"label": "Virgin Islands"},
        {"label": "Virginia"},
        {"label": "Washington"},
        {"label": "West Virginia"},
        {"label": "Wisconsin"},
        {"label": "Wyoming"}
      ]

      collection = new TrackDons.Collections.AutoComplete.Collection(states);

      $input = $('[data-behaviour=autocomplete]');

      view = new TrackDons.Views.AutoComplete.Component({
        input: $input,
        collection: collection
      }).render();

    });
  
    it('should show create the namespace properly', function() {
      expect(TrackDons.Views.AutoComplete.Component).toBeDefined();
      expect(TrackDons.Views.AutoComplete.Item).toBeDefined();
      expect(TrackDons.Collections.AutoComplete.Collection).toBeDefined();
      expect(TrackDons.Models.AutoComplete.Model).toBeDefined();
    });

    it('should show create the view properly', function() {
      expect($('.autocomplete')).toExist();
    });

    it('should show options layer', function(done) {
      $input.val("W");
      $input.keyup();

      setTimeout(function(){
        expect($('.autocomplete')).toBeVisible();
        expect($('.autocomplete-item:visible').length).toEqual(11);
        done();
      }, 500);
    })

    it('should fill value pressing enter', function(done) {
      $input.val("Wy");
      $input.keyup();

      setTimeout(function(){
        $input.simulate("keydown", {keyCode: 40});
        $input.simulate("keydown", {keyCode: 13});

        expect($input.val()).toBe('Wyoming');
        done();
      }, 500);
    });

  });
  
});