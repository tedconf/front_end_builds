import Component from '@ember/component';
import { inject as service } from '@ember/service';
import { computed } from '@ember/object';

export default Component.extend({

  classNames: Object.freeze(['Pubkey-form', 'Form']),
  store: service(),

  showNameError: computed('pubkey.name', function(){
    return !this.get('pubkey.validations.attrs.name.isValid');
  }),

  showPubkeyError: computed('pubkey.pubkey', function(){
    return !this.get('pubkey.validations.attrs.pubkey.isValid');
  }),

  didInsertElement() {
    let pubkey = this.get('store').createRecord('pubkey', {});

    this.set('pubkey', pubkey);
    this.$('input')
      .focus()
      .on('keyup', (e) => {
        if (e.keyCode === 27) {
          this.send('discardNewApp');
        }
      });
  },

  actions: {
    createPubkey() {
      this.set('isCreating', true);
      if (this.get('pubkey.validations.isValid')) {
        this.get('pubkey').save().then(() => {
          this.set('isCreating', false);
          this.dismiss();
        });
      } else {
        this.set('isCreating', false);
      }
    },

    discardNewPubkey() {
      this.get('pubkey').deleteRecord();
      this.dismiss();
    }
  }
});
