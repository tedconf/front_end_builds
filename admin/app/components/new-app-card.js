import Ember from 'ember';

export default Ember.Component.extend({
  didInsertElement: function() {
    this.$('input').focus();
  },

  actions: {
    createApp: function() {
      this.get('app').save();
    },

    removeApp: function() {
      this.get('app').deleteRecord();
    }
  }
});
