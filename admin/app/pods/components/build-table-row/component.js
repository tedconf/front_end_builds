import Component from '@ember/component';
import { inject as service } from '@ember/service';

export default Component.extend({
  classNames: Object.freeze(['Table__row']),
  classNameBindings: Object.freeze(['isLive:bg-green-lightest']),

  tagName: 'tr',

  store: service(),

  actions: {
    activate(build) {
      this.set('isLoading', true);
      let app = this.get('app');
      app.set('liveBuild', build);
      app.save().then(() => {
        this.set('isLoading', false);
      });
    }
  }
});
