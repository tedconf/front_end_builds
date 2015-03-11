/* global server */
import Ember from 'ember';
import {module, test} from 'qunit';
import startApp from '../helpers/start-app';

var App;

module('Acceptance: Apps', {
  beforeEach: function() {
    App = startApp();
    server.create('host_app', { id: 'current' });
  },
  afterEach: function() {
    Ember.run(App, 'destroy');
  }
});

test("I can view the admin overview", function(assert) {
  visit('/');

  andThen(function() {
    assert.equal(currentRouteName(), 'apps');
  });
});

test("The overview summarizes an apps current live build", function(assert) {
  server.create('app', { name: 'first-app', build_ids: [1, 2], live_build_id: 2 });
  server.create('build', { app_id: 1, sha: '123', job: 1, branch: 'nonmaster' });
  server.create('build', { app_id: 1, sha: '456', job: 2, branch: 'latest' });

  visit('/');

  andThen(function() {
    assertPageContainsText('latest');
    assertPageContainsText('456');
  });
});

test("The overview displays an info message if an app has no live build", function(assert) {
  server.create('app', { name: 'first-app' });

  visit('/');

  andThen(function() {
    assertPageContainsText('No active build');
  });
});

test("I can view an app's details", function(assert) {
 server.create('app', { name: 'first-app' });

 visit('/');
 click('a:contains("first-app")');

 andThen(function() {
   assert.equal(currentRouteName(), 'app.index');
   assertText('h1', 'first-app');
 });
});
