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
      // debugger;
      this.get('app').deleteRecord();

      // Ember.run(function() {
      //   app.deleteRecord();
      // });
      // return this.get('app').unloadRecord();
      // var app = this.get('app');
      // this.get('onCancelNewApp')(app);
    }
  }
});
