/* global server */
import Ember from 'ember';
import {module, test} from 'qunit';
import startApp from '../helpers/start-app';

var application;

module('Acceptance: Create new app', {
  beforeEach: function() {
    application = startApp();
    server.create('host_app', { id: 'current' });
  },
  afterEach: function() {
    Ember.run(application, 'destroy');
  }
});

test('I should not see the new app form when I visit the page', function(assert) {
  visit("/");
  assertExists(".New-app-form", 0);
});

test('I should see the new app form when I click the new app button', function(assert) {
  visit("/");
  click(".new-app-button");

  assertExists(".New-app-form");
});

test('I should not be able to create a new app without entering a name', function(assert) {
  visit("/");
  click(".new-app-button");

  click(".New-app-form__create");

  assertExists(".form-group.has-error .New-app-form__name");
});

test("I should be able to cancel adding a new app", function(assert) {
  visit("/");
  click(".new-app-button");

  click(".New-app-form__cancel");

  assertExists(".New-app-form", 0);
});

test('I should be able to create a new app', function(assert) {
  visit("/");
  click(".new-app-button");

  fillIn(".New-app-form__name", "Test app");
  click(".New-app-form__create");

  assertExists(".New-app-form", 0);
  assertExists(".App-card");
});
