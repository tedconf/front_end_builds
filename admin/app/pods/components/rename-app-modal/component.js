import Component from '@ember/component';
import { computed } from '@ember/object';

export default Component.extend({
  showNameError: computed('app.name', function(){
    return !this.get('app.validations.attrs.name.isValid');
  }),

  actions: {
    dismiss() {
      this.get('app').rollbackAttributes();
      this.dismiss();
    },
    submit() {
      this.set('isSubmitting', true);
      if (this.get('app.validations.isValid')) {
        this.get('app').save().then(() => {
          this.set('isSubmitting', false);
          this.dismiss();
        });
      } else {
        this.set('isSubmitting', false);
      }
    }
  }
});
