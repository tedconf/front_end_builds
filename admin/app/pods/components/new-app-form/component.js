import Component from '@ember/component';
import { inject as service } from '@ember/service';
import { computed } from '@ember/object';

export default Component.extend({

  classNames: Object.freeze(['App-form', 'Form']),
  store: service(),

  showNameError: computed('app.name', function(){
    return !this.get('app.validations.attrs.name.isValid');
  }),

  didInsertElement() {
    let app = this.get('store').createRecord('app', {});

    this.set('app', app);
    this.$('input')
      .focus()
      .on('keyup', (e) => {
        if (e.keyCode === 27) {
          this.send('discardNewApp');
        }
      });
  },

  actions: {
    createApp() {
      this.set('isCreating', true);
      if (this.get('app.validations.isValid')) {
        this.get('app').save().then(() => {
          this.set('isCreating', false);
          this.dismiss();
        });
      } else {
        this.set('isCreating', false);
      }
    },

    discardNewApp() {
      this.get('app').deleteRecord();
      this.dismiss();
    }
  }
});
