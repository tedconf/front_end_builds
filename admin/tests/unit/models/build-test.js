import {
  moduleForModel,
  test
} from 'ember-qunit';

moduleForModel('build', 'Build', {
  // Specify the other units that are required for this test.
  needs: ['model:app']
});

test('it exists', function() {
  var model = this.subject();
  // var store = this.store();
  ok(!!model);
});
