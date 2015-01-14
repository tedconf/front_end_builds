import Ember from 'ember';

export default Ember.Controller.extend({

  savedApps: Ember.computed.filterBy('model', 'isNew', false),
  newApp: function() {
    return this.get('model').filterBy('isNew', true).get('firstObject');
  }.property('model.@each.isNew'),

  actions: {
    createApp: function() {
      this.store.createRecord('app');
    }
  }
});
