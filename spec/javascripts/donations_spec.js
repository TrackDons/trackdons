describe('Donations', function() {

  var collection;

  beforeEach(function(){
    loadFixtures('donations_fixture.html');

    collection = new Backbone.Collection();

    $('.bb-donations').each(function(dom, element){
      new TrackDons.Donations({
        el: element,
        collection: collection
      });
    });
  });

  afterEach(function() {
    $('.pika-single').remove();
  });

  it('should be defined', function() {
    expect(TrackDons.Donations).toBeDefined();
  });

  it('should load fixture', function () {
    expect($('.bb-donations')).toExist();
  });

  it('should bind existing views properly', function () {
    expect($('.bb-donation').length).toBe(1);
    expect($('.select2-container').length).toBe(1);
    expect($('.pika-single').length).toBe(1);
  });

  it('should add new views properly', function () {
    $('.js-add-donation').simulate('click');

    expect(collection.length).toBe(2);
    expect($('.bb-donation').length).toBe(2);
    expect($('.select2-container').length).toBe(2);
    expect($('.pika-single').length).toBe(2);
  });
  
});