import { module, test } from 'qunit';
import { visit, currentRouteName, click, fillIn } from '@ember/test-helpers';
import { setupApplicationTest } from 'ember-qunit';
import setupMirage from 'ember-cli-mirage/test-support/setup-mirage';
import { assertionInjector } from '../assertions';

module('Acceptance | adding ssh key', function(hooks) {
  setupApplicationTest(hooks);
  setupMirage(hooks);
  hooks.beforeEach(function() {
    assertionInjector(this);
  });

  test("I should be able to get to the ssk key section from the navigation", async function(assert) {
    this.server.create('host_app', { id: 'current' });

    await visit("/");

    await click(".navbar-link__pubkeys");

    assert.equal(currentRouteName(), "pubkeys.index");
  });

  test("I should get a new SSH key form if I have never added a key", async function(assert) {
    this.server.create('host_app', { id: 'current' });

    await visit("/ssh-keys");

    assert.count(".Pubkey-form", 1);

    // should not see the new ssh key button since we are inlining
    // the form
    assert.count(".new-pubkey.btn-primary", 1);
    assert.count(".new-pubkey.btn-default", 0);

    await fillIn(".Form__name", "My first key");
    await fillIn(".Form__pubkey", "key");
    await click(".Form__buttons button.btn-success");

    assert.count(".Pubkey-table", 1);
    assert.count(".Table__row", 1);
  });

  test("I should not be able to cancel my first key form", async function(assert) {
    this.server.create('host_app', { id: 'current' });

    await visit("/ssh-keys");

    assert.count(".Form__cancel", 0);
  });

  test("I should see a list of all my keys when I have keys to display", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.createList('pubkey', 2);

    await visit("/ssh-keys");

    assert.count(".Pubkey-table", 1);
    assert.count(".Table__row", 2);
  });

  test("I should be able to add a new key", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('pubkey');

    await visit("/ssh-keys");

    await click(".new-pubkey");

    assert.count(".Pubkey-form", 1);

    await fillIn(".Form__name", "Test key");
    await fillIn(".Form__pubkey", "The key");
    await click(".Form__buttons button.btn-success");

    assert.count(".Pubkey-table", 1);
    assert.count(".Table__row", 2);
  });

  test("I should not be able to add a pubkey without the required fields", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('pubkey');

    await visit("/ssh-keys");

    await click(".new-pubkey");

    await click(".Form__buttons button.btn-success");

    assert.count(".Form__row-error", 2);
  });

  test("I should be able to cancel adding a new key", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.create('pubkey');

    await visit("/ssh-keys");

    await click(".new-pubkey");

    assert.count(".Pubkey-form", 1);

    await click(".Form__cancel");

    assert.count(".Pubkey-table", 1);
    assert.count(".Table__row", 1);
  });

  test("I should be able to delete a key", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.createList('pubkey', 2);

    await visit("/ssh-keys");

    await click(".Pubkey-table__delete");

    assert.count(".Delete-pubkey-modal", 1);

    await click(".Panel-footer button.btn-danger");

    assert.count(".Pubkey-table", 1);
    assert.count(".Table__row", 1);
  });

  test("I should be able to cancel deleting a key", async function(assert) {
    this.server.create('host_app', { id: 'current' });
    this.server.createList('pubkey', 2);

    await visit("/ssh-keys");

    await click(".Pubkey-table__delete");

    assert.count(".Delete-pubkey-modal", 1);

    await click(".Panel-footer button.btn-primary");

    assert.count(".Pubkey-table", 1);
    assert.count(".Table__row", 2);
  });
});
