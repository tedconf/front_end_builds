import Ember from 'ember';
import startApp from '../helpers/start-app';

var App;

module('Acceptance: CreateApp', {
  setup: function() {
    App = startApp();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
  }
});

test('I should be able to start creating a new app, but then cancel', function() {
  visit('/');
  click("button:contains('New app')");
  click(".appCard:last-child .fa-remove");

  andThen(function() {
    debugger;
    // TODO: need to use pretender and update this when i have mock data set up
    equal(find('.appCard').length, 1);
  });
});
