import Ember from 'ember';
import startApp from '../helpers/start-app';

var App;

module('Acceptance: App', {
  setup: function() {
    App = startApp();
    App.pretender.setupDefaultRoutes();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
  }
});

test("I can view an app's overview", function() {
  visit('/1');

  andThen(function() {
    equal(currentRouteName(), 'app');
    assertText('h1', 'Apps/first-app');
  });
});

test("I see an info message if an app has no builds", function() {
  App.pretender.stubUrl('get', '/apps/:id', {
    app: {id: 1, name: 'first-app', api_key: '123'}
  });

  visit('/1');

  andThen(function() {
    assertPageContainsText('No active build');
  });
});

test("I can view summary information about the app's current live build", function() {
  visit('/1');

  andThen(function() {
    var summaryPanel = find('.panel:contains("Current live build")');

    ok(summaryPanel.text().match('master').length);
    ok(summaryPanel.text().match('83jnbj').length);
  });
});

test("In the builds list, I can see all an app's builds", function() {
  visit('/1');

  andThen(function() {
    equal(find('.appDetail-buildListItem').length, 3);
    ok(find('.appDetail-buildListItem').eq(1).find(':contains("Live")').length > 0);
  });
});

test("In the builds list, I can which build is live", function() {
  visit('/1');

  andThen(function() {
    ok(find('.appDetail-buildListItem').eq(1).find(':contains("Live")').length > 0);
  });
});
