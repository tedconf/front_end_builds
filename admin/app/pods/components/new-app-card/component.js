import Ember from 'ember';

export default Ember.Component.extend({
  didInsertElement: function() {
    this.$('input').focus();
  },

  actions: {
    createApp: function() {
      return this.get('app').save();
    },

    discardNewApp: function() {
      this.get('app').deleteRecord();
    }
  }
});
