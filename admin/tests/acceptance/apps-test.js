import { module, test } from 'qunit';
import { visit, currentRouteName, click } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { assertionInjector } from '../assertions';

module('Acceptance | apps', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);
  hooks.beforeEach(function() {
    assertionInjector(this);
  });

  test("I can view the admin overview", async function(assert) {
    this.server.create('host_app', { id: 'current' });

    await visit('/');

    assert.equal(currentRouteName(), 'apps');
  });

  test("The overview summarizes an apps current live build", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app', { name: 'first-app', build_ids: [1, 2], live_build_id: 2 });
    this.server.create('build', { app_id: 1, sha: '123', job: 1, branch: 'nonmaster' });
    this.server.create('build', { app_id: 1, sha: '456', job: 2, branch: 'latest' });

    await visit('/');

    assert.contains('.Build-info', 'latest');
    assert.contains('.Build-info', '456');

  });

  test("The overview displays an info message if an app has no live build", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app', { name: 'first-app' });

    await visit('/');

    assert.contains('body', 'No active build');
  });

  test("I can view an app's details", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app', { name: 'first-app' });

    await visit('/');
    await click('.Panel-head__inactive a');

    assert.equal(currentRouteName(), 'app.index');
    assert.contains('h1', 'first-app');
  });
});
