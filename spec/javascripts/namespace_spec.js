describe('Namespace', function() {

  it('should be defined', function() {
    expect(TrackDons).toBeDefined();
    expect(TrackDons.Components).toBeDefined();
  });

  it('should load fixture', function () {
    loadFixtures('test_fixture.html');
    expect($('#test')).toExist();
  });
});