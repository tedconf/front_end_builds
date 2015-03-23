import Ember from 'ember';

export default Ember.Component.extend({
  action: null,
  value: null,

  actions: {
    toggle: function() {
      this.sendAction('action', !this.get('value'));
    }
  },

  classNames: ['Toggle-switch']
});
