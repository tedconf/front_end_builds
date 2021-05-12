import Controller from '@ember/controller';
import { computed } from '@ember/object';

export default Controller.extend({
  savedApps: computed.filterBy('model', 'isNew', false),

  sortBy: Object.freeze(['name']),
  orderedApps: computed.sort('savedApps', 'sortBy'),

  actions: {
    showForm() {
      this.set('isAdding', true);
    },
    hideForm() {
      this.set('isAdding', false);
    }
  }
});
