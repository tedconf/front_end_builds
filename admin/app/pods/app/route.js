import Ember from 'ember';

export default Ember.Route.extend({

  actions: {
    activateNewDeploys: function(value) {
      var app = this.controller.get('model');

      app.set('requireManualActivation', !value);
      app.save();
    },

    appDeleted: function() {
      this.set('controller.willDelete', undefined);
      this.transitionTo('apps');
    }
  }

});
