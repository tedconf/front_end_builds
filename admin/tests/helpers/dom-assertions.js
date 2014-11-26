import Ember from 'ember';

Ember.Test.registerAsyncHelper('assertExists', function(app, selector, times) {
  if (arguments.length < 3) {
    times = 1;
  }

  return wait()
    .find(selector)
    .then(function(element) {
      equal(element.length, times, "found " + selector + " " + times + "  times");
    });
});

Ember.Test.registerAsyncHelper('assertText', function(app, selector, text) {
  return wait()
    .find(selector)
    .then(function(element) {
      equal(element.text().trim(), text, "found " + selector + " with " + text);
    });
});

Ember.Test.registerAsyncHelper('assertPageContainsText', function(app, text) {
  return wait()
    .then(function() {
      var element = $('#ember-testing:contains("' + text + '")');
      equal(element.length, 1, 'Found ' + text + ' on page');
    });
});

export default {};
