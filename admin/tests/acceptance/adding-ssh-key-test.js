import Ember from 'ember';
import startApp from '../helpers/start-app';

var application;

module('Acceptance: SSH keys', {
  setup: function() {
    application = startApp();
    store.loadData({
      hostApps: [{id: 'current', name: 'acme_portal'}],
      apps: [],
      builds: [],
      pubkeys: []
    });
  },
  teardown: function() {
    Ember.run(application, 'destroy');
  }
});

test("I should be able to get to the ssk key section from the navigation", function() {
  visit("/");

  click(".Navigation-links__pubkeys");

  andThen(function() {
    equal(currentRouteName(), "pubkeys.index");
  });
});

test("I should get a new SSH key form if I have never added a key", function() {
  visit("/ssh-keys");
  assertExists(".Pubkey-form");

  // should not see the new ssh key button since we are inlining
  // the form
  assertExists(".new-pubkey", 0);

  fillIn(".Pubkey-form__name", "My first key");
  fillIn(".Pubkey-form__pubkey", "key");
  click(".Pubkey-form__save");

  assertExists(".Pubkey-table");
  assertExists(".Pubkey-table__pubkey", 1);
});

test("I should end up back on the apps page if I cancel adding my first key", function() {
  visit("/ssh-keys");
  click(".Pubkey-form__cancel");

  andThen(function() {
    equal(currentRouteName(), "apps");
  });
});

test("I should see a list of all my keys when I have keys to display", function() {
  store.loadData([
      { id: 1, name: 'Key 1' },
      { id: 2, name: 'Key 2' }
    ], 'pubkeys');

  visit("/ssh-keys");

  assertExists(".Pubkey-table");
  assertExists(".Pubkey-table__pubkey", 2);
});

test("I should be able to add a new key", function() {
  store.loadData([{ id: 1, name: 'Key 1' } ], 'pubkeys');

  visit("/ssh-keys");

  click(".new-pubkey");

  assertExists(".Pubkey-form");
  fillIn(".Pubkey-form__name", "Test key");
  fillIn(".Pubkey-form__pubkey", "The key");
  click(".Pubkey-form__save");

  assertExists(".Pubkey-table");
  assertExists(".Pubkey-table__pubkey", 2);
});

test("I should not be able to add a pubkey without the required fields", function() {
  store.loadData([{ id: 1, name: 'Key 1' } ], 'pubkeys');

  visit("/ssh-keys");

  click(".new-pubkey");

  click(".Pubkey-form__save");

  assertExists(".Pubkey-form .form-group.has-error", 2);
});

test("I should be able to cancel adding a new key", function() {
  store.loadData([{ id: 1, name: 'Key 1' } ], 'pubkeys');

  visit("/ssh-keys");

  click(".new-pubkey");

  assertExists(".Pubkey-form");
  click(".Pubkey-form__cancel");

  assertExists(".Pubkey-table");
  assertExists(".Pubkey-table__pubkey", 1);
});

test("I should be able to delete a key", function() {
  store.loadData([
      { id: 1, name: 'Key 1' },
      { id: 2, name: 'Key 2' }
    ], 'pubkeys');

  visit("/ssh-keys");

  click(".Pubkey-table__delete:first");

  assertExists(".Delete-pubkey-modal");

  click(".Delete-pubkey-modal__confirm-delete");

  assertExists(".Pubkey-table__pubkey", 1);
});

test("I should be able to cancel deleting a key", function() {
  store.loadData([
      { id: 1, name: 'Key 1' },
      { id: 2, name: 'Key 2' }
    ], 'pubkeys');

  visit("/ssh-keys");

  click(".Pubkey-table__delete:first");

  assertExists(".Delete-pubkey-modal");

  click(".Delete-pubkey-modal__cancel");

  assertExists(".Pubkey-table__pubkey", 2);
});
