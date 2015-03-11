import Ember from 'ember';
import {module, test} from 'qunit';
import startApp from '../helpers/start-app';
/* global server */

var App;

module('Acceptance: App', {
  beforeEach: function() {
    App = startApp();
    server.create('host_app', { id: 'current' });
  },
  afterEach: function() {
    Ember.run(App, 'destroy');
  }
});

test("I can view an app's overview", function(assert) {
  server.create('app', { name: 'CRM' });

  visit('/apps/1');

  andThen(function() {
    assert.equal(currentRouteName(), 'app.index');
    assertText('h1', 'CRM');
  });
});

test("I see an info message if an app has no builds", function(assert) {
  server.create('app');

  visit('/apps/1');

  andThen(function() {
    assertPageContainsText('No active build');
  });
});

test("I see an info message if an app has builds, but none are live", function(assert) {
  server.create('app', { build_ids: [1] });
  server.create('build', { app_id: 1 });

  visit('/apps/1');

  andThen(function() {
    assertPageContainsText('No active build');
  });
});

test("I can view summary information about the app's current live build", function(assert) {
  server.create('app', {
    build_ids: [1],
    live_build_id: 1
  });

  server.create('build', {
    app_id: 1,
    branch: 'master',
    sha: '123'
  });

  visit('/apps/1');

  andThen(function() {
    var summaryPanel = find('.panel-success:contains("Active build")');

    assert.ok(summaryPanel.text().match('master').length);
    assert.ok(summaryPanel.text().match('123').length);
  });
});

test("In the builds list, I can see all an app's builds", function(assert) {
  server.create('app', { name: 'blog', build_ids: [1, 2, 3] });
  server.create('build', { app_id: 1, branch: 'master', sha: '123' });
  server.create('build', { app_id: 1, branch: 'master', sha: '789' });
  server.create('build', { app_id: 1, branch: 'master', sha: '456' });

  visit('/apps/1');

  andThen(function() {
    assert.equal(find('.Build-list__build-row').length, 3);
  });
});

test("In the builds list, I can view which build is live", function(assert) {
  server.create('app', { name: 'blog', build_ids: [1, 2, 3], live_build_id: 1 });
  server.create('build', { app_id: 1, branch: 'master', sha: '123' });
  server.create('build', { app_id: 1, branch: 'master', sha: '456' });
  server.create('build', { app_id: 1, branch: 'master', sha: '789' });

  visit('/apps/1');

  assertExists('.Build-list__control-live-button--live');
});

test("I can delete an app", function(assert) {
 server.create('app', { name: 'blog' });

 visit('/apps/1');

 click('button:contains("Delete")');

 fillIn('input', 'blog');
 click('button:contains("I understand")');

 andThen(function() {
   assert.equal(currentRouteName(), 'apps');
   assert.equal(find('.App-card').length, 0);
 });
});
