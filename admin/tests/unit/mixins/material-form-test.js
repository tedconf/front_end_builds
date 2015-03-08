import Ember from 'ember';
import MaterialFormMixin from 'admin/mixins/material-form';

module('MaterialFormMixin');

// Replace this with your real tests.
test('it works', function() {
  var MaterialFormObject = Ember.Object.extend(MaterialFormMixin);
  var subject = MaterialFormObject.create();
  ok(subject);
});
