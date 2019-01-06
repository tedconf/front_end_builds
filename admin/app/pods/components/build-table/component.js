import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  classNames: Object.freeze(['Build-table']),

  store: service(),
  page: 1,

  didInsertElement() {
    let page = this.get('page');
    this.get('store').query('build', { app_id: this.get('app').id, page: page }).then(() => {
      this.set('page', page+1);
    });
  },

  actions: {
    activate(build) {
      let app = this.get('app');
      app.set('liveBuild', build);
      app.save();
    }
  }
});
