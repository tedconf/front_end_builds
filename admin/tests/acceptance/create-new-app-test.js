/* global server */
import Ember from 'ember';
import startApp from '../helpers/start-app';

var application;

module('Acceptance: Create new app', {
  setup: function() {
    application = startApp();

    server.loadData({
      hostApps: [{ id: 'current', name: 'Test' }],
      apps: []
    });
  },
  teardown: function() {
    Ember.run(application, 'destroy');
  }
});

test('I should not see the new app form when I visit the page', function() {
  visit("/");
  assertExists(".New-app-form", 0);
});

test('I should see the new app form when I click the new app button', function() {
  visit("/");
  click(".new-app-button");

  assertExists(".New-app-form");
});

test('I should not be able to create a new app without entering a name', function() {
  visit("/");
  click(".new-app-button");

  click(".New-app-form__create");

  assertExists(".form-group.has-error .New-app-form__name");
});

test("I should be able to cancel adding a new app", function() {
  visit("/");
  click(".new-app-button");

  click(".New-app-form__cancel");

  assertExists(".New-app-form", 0);
});

test('I should be able to create a new app', function() {
  visit("/");
  click(".new-app-button");

  fillIn(".New-app-form__name", "Test app");
  click(".New-app-form__create");

  assertExists(".New-app-form", 0);
  assertExists(".App-card");
});
