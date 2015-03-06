import Ember from 'ember';
import EmberValidations from 'ember-validations';

export default Ember.Component.extend(EmberValidations.Mixin, {
  pubkey: null,
  saveAction: "save",
  cancelAction: "cancel",

  classNames: ['Pubkey-form'],

  isValidating: false,

  validations: {
    'pubkey.name': { presence: true },
    'pubkey.pubkey': { presence: true }
  },

  hasNoNameError: Ember.computed.empty('errors.pubkey.name'),
  hasNameError: Ember.computed.not('hasNoNameError'),
  showNameError: Ember.computed.and('hasNameError', 'isValidating'),

  hasNoPubkeyError: Ember.computed.empty('errors.pubkey.pubkey'),
  hasPubkeyError: Ember.computed.not('hasNoPubkeyError'),
  showPubkeyError: Ember.computed.and('hasPubkeyError', 'isValidating'),

  actions: {
    save: function() {
      var component = this,
          pubkey = this.get('pubkey');

      this.set('isValidating', true);

      this.validate()
        .then(function() {
          component.set('isValidating', false);
          component.sendAction('saveAction', pubkey);
        });
    },

    cancel: function() {
      this.sendAction('cancelAction');
    }
  }
});
