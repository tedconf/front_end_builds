/* global server */
import Ember from 'ember';
import startApp from '../helpers/start-app';

var App;

module('Acceptance: Apps', {
  setup: function() {
    App = startApp();
    server.loadData({
      hostApps: [{id: 'current', name: 'acme_portal'}],
      apps: [],
      builds: []
    });
  },
  teardown: function() {
    Ember.run(App, 'destroy');
  }
});

test("I can view the admin overview", function() {
  visit('/');

  andThen(function() {
    equal(currentRouteName(), 'apps');
  });
});

test("The overview summarizes an apps current live build", function() {
  server.create('app', { name: 'first-app', build_ids: [1, 2], live_build_id: 2 });
  server.create('build', { app_id: 1, sha: '123', job: 1, branch: 'nonmaster' });
  server.create('build', { app_id: 1, sha: '456', job: 2, branch: 'latest' });

  visit('/');

  andThen(function() {
    assertPageContainsText('latest');
    assertPageContainsText('456');
  });
});

test("The overview displays an info message if an app has no live build", function() {
  server.create('app', { name: 'first-app' });

  visit('/');

  andThen(function() {
    assertPageContainsText('No active build');
  });
});

test('I can start creating a new app, but then cancel', function() {
  visit('/');
  click('button:contains("New app")');

  click('.App-card:last .fa-remove');

  andThen(function() {
    equal(find('.App-card').length, 0);
  });
});

test('I can create a new app', function() {
  visit('/');
  click('button:contains("New app")');
  fillIn('.App-card__new-input', 'my-new-app');
  click('button:contains("Create")');

  andThen(function() {
    equal(find('.App-card').length, 1);
    assertText('.App-card:last .panel-title', 'my-new-app');
  });
});

test("I can view an app's details", function() {
 server.create('app', { name: 'first-app' });

 visit('/');
 click('a:contains("first-app")');

 andThen(function() {
   equal(currentRouteName(), 'app.index');
   assertText('h1', 'first-app');
 });
});
