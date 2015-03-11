import {
  moduleForModel,
  test
} from 'ember-qunit';

moduleForModel('app', 'App', {
  // Specify the other units that are required for this test.
  needs: ['model:build']
});

test('it exists', function(assert) {
  var model = this.subject();
  // var store = this.store();
  assert.ok(!!model);
});
