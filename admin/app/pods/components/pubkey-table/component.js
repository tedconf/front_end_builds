import Ember from 'ember';

export default Ember.Component.extend({
  tagName: 'table',
  classNames: 'Pubkey-table table'.w(),

  removeAction: "remove",

  actions: {
    remove: function(pubkey) {
      this.sendAction('removeAction', pubkey);
    }
  },

  displayKeys: Ember.computed.filterBy('pubkeys', 'id'),
});
