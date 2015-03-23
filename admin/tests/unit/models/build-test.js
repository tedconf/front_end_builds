import {
  moduleForModel,
  test
} from 'ember-qunit';

moduleForModel('build', 'Build', {
  // Specify the other units that are required for this test.
  needs: ['model:app']
});

test('it exists', function(assert) {
  var model = this.subject();
  // var store = this.store();
  assert.ok(!!model);
});
