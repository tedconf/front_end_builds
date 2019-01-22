import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  classNames: Object.freeze(['Build-table']),

  store: service(),
  page: 1,

  didInsertElement() {
    this.loadPage(this.get('page'));
  },

  loadPage(page) {
    this.set('isLoading', true);
    this.get('store').query('build', { app_id: this.get('app').id, page: page }).then(() => {
      this.setProperties({
        isLoading: false,
        page: page+1
      });
    });
  },

  actions: {
    loadMore() {
      this.loadPage(this.get('page'));
    }
  }
});
