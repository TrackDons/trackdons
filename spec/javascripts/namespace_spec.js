describe('Namespace', function() {

  it('should be defined', function() {
    expect(TrackDons).toBeDefined();
    expect(TrackDons.Models).toBeDefined();
    expect(TrackDons.Collections).toBeDefined();
    expect(TrackDons.Views).toBeDefined();
  });

  it('should load fixture', function () {
    loadFixtures('test_fixture.html');
    expect($('#test')).toExist();
  });
});