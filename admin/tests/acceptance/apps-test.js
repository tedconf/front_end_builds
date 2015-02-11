import Ember from 'ember';
import startApp from '../helpers/start-app';

var App;

module('Acceptance: Apps', {
  setup: function() {
    App = startApp();
  },
  teardown: function() {
    Ember.run(App, 'destroy');
  }
});

// test("I can view the admin overview", function() {
//   visit('/');

//   andThen(function() {
//     equal(currentRouteName(), 'apps');
//   });
// });

// test("The overview summarizes an apps current live build", function() {
//   App.pretender.stubUrl('get', '/apps', {
//     apps: [
//       {id: 1, name: 'first-app', api_key: '123', build_ids: [1, 2], live_build_id: 2}
//     ],
//     builds: [
//       {id: 1, app_id: 1, sha: '123', job: 1, branch: 'nonmaster'},
//       {id: 2, app_id: 1, sha: '456', job: 2, branch: 'latest' }
//     ]
//   });

//   visit('/');

//   andThen(function() {
//     assertPageContainsText('latest');
//     assertPageContainsText('456');
//   });
// });

// test("The overview displays an info message if an app has no live build", function() {
//   App.pretender.stubUrl('get', '/apps', {
//     apps: [
//       {id: 1, name: 'first-app', api_key: '123'}
//     ],
//   });

//   visit('/');

//   andThen(function() {
//     assertPageContainsText('No active build');
//   });
// });

// test('I can start creating a new app, but then cancel', function() {
//   visit('/');
//   click('button:contains("New app")');
//   click('.appCard:last .fa-remove');

//   andThen(function() {
//     equal(find('.appCard').length, 1);
//   });
// });

// test('I can create a new app', function() {
//   visit('/');
//   click('button:contains("New app")');
//   fillIn('.appCard-newInput', 'my-new-app');
//   click('button:contains("Create")');

//   andThen(function() {
//     equal(find('.appCard').length, 2);
//     assertText('.appCard:last .panel-title', 'my-new-app');
//   });
// });

// test("I can view an app's details", function() {
//   visit('/');
//   click('a:contains("first-app")');

//   andThen(function() {
//     equal(currentRouteName(), 'app');
//     assertText('h1', 'Apps/first-app');
//   });
// });
