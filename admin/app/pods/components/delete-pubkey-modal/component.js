import Ember from 'ember';

export default Ember.Component.extend({
  pubkey: null,
  removeAction: "remove",

  classNames: ["Delete-pubkey-modal"],

  actions: {
    remove: function() {
      this.sendAction('removeAction', this.get('pubkey'));
    },

    dismiss: function() {
      this.sendAction('dismiss');
    }
  }
});
