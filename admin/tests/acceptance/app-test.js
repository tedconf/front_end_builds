import { module, test } from 'qunit';
import { visit, currentRouteName, click, fillIn } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { assertionInjector } from '../assertions';

module('Acceptance | app', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);
  hooks.beforeEach(function() {
    assertionInjector(this);
  });

  test('I can view an app\'s overview', async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app', { name: 'CRM' });

    await visit('/apps/1');

    assert.equal(currentRouteName(), 'app.index');
    assert.contains('h1', 'CRM');
  });

  test('I see an info message if an app has no builds', async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app');

    await visit('/apps/1');

    assert.contains('body', 'No active build');
  });

  test("I see an info message if an app has builds, but none are live", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app', { build_ids: [1] });
    this.server.create('build', { app_id: 1 });

    visit('/apps/1');

    assert.contains('body', 'No active build');
  });

  test("I can view summary information about the app's current live build", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app', {
      build_ids: [1],
      live_build_id: 1
    });

    this.server.create('build', {
      app_id: 1,
      branch: 'master',
      sha: '123'
    });

    await visit('/apps/1');

    assert.contains('.Build-info', 'master');
    assert.contains('.Build-info', '123');
  });


  test("In the builds list, I can see all an app's builds", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app', { name: 'blog', build_ids: [1, 2, 3] });
    this.server.create('build', { app_id: 1, branch: 'master', sha: '123' });
    this.server.create('build', { app_id: 1, branch: 'master', sha: '789' });
    this.server.create('build', { app_id: 1, branch: 'master', sha: '456' });

    await visit('/apps/1');

    assert.count(".Build-table .Table__row", 3);
  });

  test("In the builds list, I can view which build is live", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app', { name: 'blog', build_ids: [1, 2, 3], live_build_id: 1 });
    this.server.create('build', { app_id: 1, branch: 'master', sha: '123' });
    this.server.create('build', { app_id: 1, branch: 'master', sha: '456' });
    this.server.create('build', { app_id: 1, branch: 'master', sha: '789' });

    await visit('/apps/1');

    assert.count(".Build-table a.btn-default", 1);
  });

  test("I can delete an app", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app', { name: 'blog' });

    await visit('/apps/1');

    await click('button.delete-app-button');

    await fillIn('input.Form__name', 'blog');
    await click('button.btn-danger');

   assert.equal(currentRouteName(), 'apps');
   assert.count(".App-card", 0);
  });
});
