import Ember from 'ember';

export default Ember.Component.extend({
  canDelete: function() {
    return this.get('app.name') === this.get('confirmedName');
  }.property('app.name', 'confirmedName'),

  actions: {
    dismiss: function() {
      this.sendAction('dismiss');
    },

    deleteApp: function() {
      this.get('app').destroyRecord().then(() => {
        this.sendAction('deleted');
      }, function() {
        console.error('something happened');
      });
    }
  }
});
