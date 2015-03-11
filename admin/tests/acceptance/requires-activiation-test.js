/* global server */
import Ember from 'ember';
import {module, test} from 'qunit';
import startApp from '../helpers/start-app';

var application;

module('Acceptance: Require Activiation', {
  beforeEach: function() {
    application = startApp();
    server.create('host_app', { id: 'current' });
  },
  afterEach: function() {
    Ember.run(application, 'destroy');
  }
});

test('I should be able to toggle a build to require activation', function(assert) {
  server.create('app', { name: 'x', require_manual_activation: 'true' });

  visit("/apps/1");

  // requires manual panel
  assertExists(".panel-default:contains('Automatically activate new deploys')");

  click(".panel-default:contains('Automatically activate new deploys') .togglebutton");

  // automatically activated panel
  assertExists(".panel-success:contains('Automatically activate new deploys')");

});

