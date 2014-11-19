import Ember from 'ember';

export default Ember.Route.extend({

  model: function() {
    return this.store.find('app');
  },

  actions: {
    createApp: function() {
      this.store.createRecord('app');
    }
  }

});
