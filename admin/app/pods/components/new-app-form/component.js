import Ember from 'ember';
import EmberValidations from 'ember-validations';

export default Ember.Component.extend(
  EmberValidations, {

  classNames: ['New-app-form'],

  clients: ['web','mobile'],
  hasNoNameError: Ember.computed.empty('errors.app.name'),
  hasNameError: Ember.computed.not('hasNoNameError'),
  showNameError: Ember.computed.and('hasNameError', 'isValidating'),

  validations: {
    'app.name': { presence: true }
  },

  didInsertElement: function() {
    this.$('input')
      .focus()
      .on('keyup', (e) => {
        if (e.keyCode === 27) {
          this.send('discardNewApp');
        }
      });
  },

  actions: {
    createApp: function(callback) {
      this.set('isValidating', true);

      var promise = this.validate()
        .then(() => this.set('isValidating', false))
        .then(() => this.get('app').save());

      callback(promise);
    },

    discardNewApp: function() {
      this.get('app').deleteRecord();
    }
  }
});
