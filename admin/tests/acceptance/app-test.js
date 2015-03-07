import Ember from 'ember';
import startApp from '../helpers/start-app';
/* global server */

var App;

module('Acceptance: App', {
  setup: function() {
    App = startApp();
    server.loadData({
      hostApps: [ {id: 'current', name: 'acme_portal'} ],
      apps: [],
      builds: []
    });
  },
  teardown: function() {
    Ember.run(App, 'destroy');
  }
});

test("I can view an app's overview", function() {
  server.create('app', { name: 'CRM' });

  visit('/apps/1');

  andThen(function() {
    equal(currentRouteName(), 'app.index');
    assertText('h1', 'CRM');
  });
});

test("I see an info message if an app has no builds", function() {
  server.create('app');

  visit('/apps/1');

  andThen(function() {
    assertPageContainsText('No active build');
  });
});

test("I see an info message if an app has builds, but none are live", function() {
  server.create('app', { build_ids: [1] });
  server.create('build', { app_id: 1 });

  visit('/apps/1');

  andThen(function() {
    assertPageContainsText('No active build');
    equal(find('.appDetail-buildListItem').length, 1);
  });
});

test("I can view summary information about the app's current live build", function() {
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
    var summaryPanel = find('.panel:contains("Current live build")');

    ok(summaryPanel.text().match('master').length);
    ok(summaryPanel.text().match('123').length);
  });
});

test("In the builds list, I can see all an app's builds", function() {
  server.create('app', { name: 'blog', build_ids: [1, 2, 3] });
  server.create('build', { app_id: 1, branch: 'master', sha: '123' });
  server.create('build', { app_id: 1, branch: 'master', sha: '789' });
  server.create('build', { app_id: 1, branch: 'master', sha: '456' });

  visit('/apps/1');

  andThen(function() {
    equal(find('.appDetail-buildListItem').length, 3);
  });
});

test("In the builds list, I can view which build is live", function() {
  server.create('app', { name: 'blog', build_ids: [1, 2, 3], live_build_id: 1 });
  server.create('build', { app_id: 1, branch: 'master', sha: '123' });
  server.create('build', { app_id: 1, branch: 'master', sha: '456' });
  server.create('build', { app_id: 1, branch: 'master', sha: '789' });

  visit('/apps/1');

  andThen(function() {
    ok(find('.appDetail-buildListItem').eq(0).find(':contains("Live")').length > 0);
  });
});

test("I can delete an app", function() {
 server.create('app', { name: 'blog' });

 visit('/apps/1');
 click('a:contains("Delete")');

 fillIn('input', 'blog');
 click('button:contains("I understand")');

 andThen(function() {
   equal(currentRouteName(), 'apps');
   equal(find('.appCard').length, 0);
 });
});
