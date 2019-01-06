import Component from '@ember/component';
import { filterBy } from '@ember/object/computed';

export default Component.extend({
  classNames: Object.freeze(['Pubkey-table']),

  removeAction: "remove",

  actions: {
    remove(pubkey) {
      this.removeAction(pubkey);
    }
  },

  displayKeys: filterBy('pubkeys', 'id'),
});
