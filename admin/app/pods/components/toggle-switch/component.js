import Ember from 'ember';
import MaterialForm from '../../../mixins/material-form';

export default Ember.Component.extend(
  MaterialForm, {

  action: null,
  value: null,

  actions: {
    toggle: function() {
      this.sendAction('action', !this.get('value'));
    }
  },

  classNames: ['Toggle-switch']
});
