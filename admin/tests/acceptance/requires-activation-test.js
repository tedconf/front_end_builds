import { module, test } from 'qunit';
import { visit, click } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { assertionInjector } from '../assertions';

module('Acceptance | requires activation', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);
  hooks.beforeEach(function() {
    assertionInjector(this);
  });

  test('I should be able to toggle a build to require activation', async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('app', { name: 'x', require_manual_activation: 'true' });

    await visit("/apps/1");

    // requires manual panel
    assert.count(".Panel__manual-activation .Panel-head__inactive", 1);

    await click(".Panel__manual-activation .Input-switch__checkbox");

    // automatically activated panel
    assert.count(".Panel__manual-activation .Panel-head__active", 1);
  });
});
