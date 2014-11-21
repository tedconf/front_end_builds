import Ember from 'ember';

export default Ember.Component.extend({
  didInsertElement: function() {
    this.$('input').focus();
  },

  actions: {
    createApp: function() {
      return this.get('app').save();
    },

    cancelNewApp: function() {
      return this.get('app').deleteRecord();
      // var app = this.get('app');
      // this.get('onCancelNewApp')(app);
    }
  }
});
