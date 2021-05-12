/* global QUnit */
import { registerAsyncHelper } from '@ember/test';
import $ from 'jquery';
import { wait } from 'ember-test-helpers';

// console.log('running');

registerAsyncHelper('assertExists', function(app, selector, times) {
  if (arguments.length < 3) {
    times = 1;
  }

  return wait()
    .find(selector)
    .then(function(element) {
      QUnit.assert.equal(element.length, times, "found " + selector + " " + times + "  times");
    });
});

registerAsyncHelper('assertText', function(app, selector, text) {
  return wait()
    .find(selector)
    .then(function(element) {
      QUnit.assert.equal(element.text().trim(), text, "found " + selector + " with " + text);
    });
});

registerAsyncHelper('assertPageContainsText', function(app, text) {
  return wait()
    .then(function() {
      var element = $('#ember-testing:contains("' + text + '")');
      QUnit.assert.equal(element.length, 1, 'Found ' + text + ' on page');
    });
});

export default {};
