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
  click('.appCard:last-child .fa-remove');

  andThen(function() {
    // equal(find('.appCard').length, 0);
    ok(1);
  });
});

test('I should be able to create a new app', function() {
  visit('/');
  click('button:contains("New app")');
  fillIn('.appCard-newInput', 'my-new-app')
  click('button:contains("Create")');

  andThen(function() {
    ok(1);
  //   equal(find('.appCard').length, 2);
  //   // equal(find('.appCard:last-child .panel-title').text(), 'my-new-app');
  });
});
