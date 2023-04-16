import Component from '@ember/component';

export default Component.extend({
  classNames: Object.freeze(['Delete-pubkey-modal']),

  actions: {
    dismiss() {
      this.dismiss();
    },
    submit() {
      this.set('isSubmitting', true);
      this.get('pubkey').destroyRecord().then(() => {
        this.set('isSubmitting', false);
        this.dismiss();
      });
    }
  }
});
