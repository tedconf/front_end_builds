import Ember from 'ember';
import startApp from '../helpers/start-app';

var App;

module('Acceptance: CreateApp', {
  setup: function() {
    App = startApp();
    App.pretender.setupDefaultRoutes();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
  }
});

test('I should be able to start creating a new app, but then cancel', function() {
  App.pretender.stubUrl('get', '/apps', {apps: []});

  visit('/');
  click('button:contains("New app")');
  click('.appCard:last .fa-remove');

  andThen(function() {
    equal(find('.appCard').length, 0);
  });
});

test('I should be able to create a new app', function() {
  visit('/');
  click('button:contains("New app")');
  fillIn('.appCard-newInput', 'my-new-app');
  click('button:contains("Create")');

  andThen(function() {
    equal(find('.appCard').length, 2);
    assertText('.appCard:last .panel-title', 'my-new-app');
  });
});
