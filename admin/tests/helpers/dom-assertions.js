/* global QUnit */
import Ember from 'ember';

console.log('running');

Ember.Test.registerAsyncHelper('assertExists', function(app, selector, times) {
  if (arguments.length < 3) {
    times = 1;
  }

  return wait()
    .find(selector)
    .then(function(element) {
      QUnit.assert.equal(element.length, times, "found " + selector + " " + times + "  times");
    });
});

Ember.Test.registerAsyncHelper('assertText', function(app, selector, text) {
  return wait()
    .find(selector)
    .then(function(element) {
      QUnit.assert.equal(element.text().trim(), text, "found " + selector + " with " + text);
    });
});

Ember.Test.registerAsyncHelper('assertPageContainsText', function(app, text) {
  return wait()
    .then(function() {
      var element = $('#ember-testing:contains("' + text + '")');
      QUnit.assert.equal(element.length, 1, 'Found ' + text + ' on page');
    });
});

export default {};
