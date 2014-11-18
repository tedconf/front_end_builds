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

test('I should be able to create a new app', function() {
  visit('/');

});
