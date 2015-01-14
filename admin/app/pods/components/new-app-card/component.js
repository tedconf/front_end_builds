import Ember from 'ember';

export default Ember.Component.extend({
  didInsertElement: function() {
    this.$('input')
      .focus()
      .on('keyup', (e) => {
        if (e.keyCode == 27) {
          this.send('discardNewApp');
        }
      });
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
