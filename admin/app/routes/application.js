import Ember from 'ember';

export default Ember.Route.extend({

  actions: {
    createApp: function() {
      var app = this.store.createRecord('app', {
        name: this.controller.get('name')
      });

      app.save();
    }
  }

});
