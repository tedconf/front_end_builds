import Ember from 'ember';
import startApp from '../helpers/start-app';

var App;

module('Acceptance: App', {
  setup: function() {
    App = startApp();
    serverData.hostApps = [ {id: 'current', name: 'acme_portal'} ];
  },
  teardown: function() {
    Ember.run(App, 'destroy');
  }
});

test("I can view an app's overview", function() {
  serverData.apps = [ {id: 1, name: 'blog'} ];

  visit('/1');

  andThen(function() {
    equal(currentRouteName(), 'app.index');
    assertText('h1', 'Apps/blog');
  });
});

test("I see an info message if an app has no builds", function() {
  serverData.apps = [ {id: 1, name: 'blog'} ];

  visit('/1');

  andThen(function() {
    assertPageContainsText('No active build');
  });
});

test("I see an info message if an app has builds, but none are live", function() {
  serverData.apps = [ {id: 1, name: 'blog', build_ids: [1]} ];
  serverData.builds = [ {id: 1, app_id: 1, sha: '123'} ];

  visit('/1');

  andThen(function() {
    assertPageContainsText('No active build');
    equal(find('.appDetail-buildListItem').length, 1);
  });
});

test("I can view summary information about the app's current live build", function() {
  serverData.apps = [ {id: 1, name: 'blog', build_ids: [1], live_build_id: 1} ];
  serverData.builds = [ {id: 1, app_id: 1, branch: 'master', sha: '123'} ];

  visit('/1');

  andThen(function() {
    var summaryPanel = find('.panel:contains("Current live build")');

    ok(summaryPanel.text().match('master').length);
    ok(summaryPanel.text().match('123').length);
  });
});

test("In the builds list, I can see all an app's builds", function() {
  serverData.apps = [ {id: 1, name: 'blog', build_ids: [1, 2, 3] } ];
  serverData.builds = [
    {id: 1, app_id: 1, branch: 'master', sha: '123'},
    {id: 2, app_id: 1, branch: 'master', sha: '456'},
    {id: 3, app_id: 1, branch: 'master', sha: '789'}
  ];

  visit('/1');

  andThen(function() {
    equal(find('.appDetail-buildListItem').length, 3);
  });
});

test("In the builds list, I can view which build is live", function() {
  serverData.apps = [ {id: 1, name: 'blog', build_ids: [1, 2, 3], live_build_id: 1 } ];
  serverData.builds = [
    {id: 1, app_id: 1, branch: 'master', sha: '123'},
    {id: 2, app_id: 1, branch: 'master', sha: '456'},
    {id: 3, app_id: 1, branch: 'master', sha: '789'}
  ];

  visit('/1');

  andThen(function() {
    ok(find('.appDetail-buildListItem').eq(0).find(':contains("Live")').length > 0);
  });
});

test("I can delete an app", function() {
  serverData.apps = [ {id: 1, name: 'blog'} ];

  visit('/1');
  click('a:contains("Delete")');
  fillIn('input', 'blog');
  Ember.run.next(this, function() {

    click('button:contains("I understand")');

  });

  andThen(function() {
    debugger;
    equal(currentRouteName(), 'apps.index');
    equal(find('.appCard').length, 0);
  });
});
