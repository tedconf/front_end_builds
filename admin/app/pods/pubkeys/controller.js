import Controller from '@ember/controller';
import { computed } from '@ember/object';

export default Controller.extend({
  displayableKeys: computed.filterBy('model', 'id'),
  hasKeys: computed.gt('displayableKeys.length', 0),

  actions: {
    showForm() {
      this.set('isAdding', true);
    },
    hideForm() {
      this.set('isAdding', false);
    },

    startDeletingPubkey(pubkey) {
      this.setProperties({
        isDeletingPubkey: true,
        pubkey
      });
    },

    stopDeletingPubkey() {
      this.setProperties({
        isDeletingPubkey: false,
        pubkey: null
      });
    },
  }
});
