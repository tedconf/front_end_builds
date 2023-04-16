import Component from '@ember/component';
import { inject as service } from '@ember/service';
import { computed } from '@ember/object';

export default Component.extend({
  router: service(),

  showNameError: computed('app.name', 'confirmedName', function(){
    return this.get('app.name') !== this.get('confirmedName');
  }),

  actions: {
    dismiss() {
      this.dismiss();
    },
    submit() {
      this.set('isSubmitting', true);
      if (!this.get('showNameError')) {
        this.get('app').destroyRecord().then(() => {
          this.set('isSubmitting', false);
          this.dismiss();
          this.get('router').transitionTo('apps');
        });
      } else {
        this.set('isSubmitting', false);
      }
    }
  }
});
