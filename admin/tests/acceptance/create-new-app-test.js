import { module, test } from 'qunit';
import { visit, click, fillIn } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { assertionInjector } from '../assertions';

module('Acceptance | create new app', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);
  hooks.beforeEach(function() {
    assertionInjector(this);
  });

  test('I should not see the new app form when I visit the page', async function(assert) {
    this.server.create('host_app', { id: 'current' });

    await visit("/");

    assert.count(".App-form", 0);
  });

  test('I should see the new app form when I click the new app button', async function(assert) {
    this.server.create('host_app', { id: 'current' });

    await visit("/");
    await click(".new-app");

    assert.count(".App-form", 1);
  });

  test('I should not be able to create a new app without entering a name', async function(assert) {
    this.server.create('host_app', { id: 'current' });

    await visit("/");
    await click(".new-app");

    assert.count(".App-form", 1);

    await click(".Form__buttons button.btn-success");

    assert.count(".Form__row-error", 1);
  });

  test("I should be able to cancel adding a new app", async function(assert) {
    this.server.create('host_app', { id: 'current' });

    await visit("/");
    await click(".new-app");

    assert.count(".App-form", 1);

    await click(".Form__cancel");

    assert.count(".App-form", 0);
  });

  test('I should be able to create a new app', async function(assert) {
    this.server.create('host_app', { id: 'current' });

    await visit("/");
    await click(".new-app");

    assert.count(".App-form", 1);

    await fillIn(".Form__name", "Test app");
    await click(".Form__buttons button.btn-success");

    assert.count(".App-form", 0);
    assert.count(".App-card", 1);
  });
});
