import Ember from 'ember';

export default Ember.Route.extend({

  model: function() {
    return this.store.find('app');
  },

  setupController: function(controller, model) {
    controller.set('attrs.apps', model);
  },

  actions: {
    createApp: function() {
      this.store.createRecord('app');
    }
  }

});
