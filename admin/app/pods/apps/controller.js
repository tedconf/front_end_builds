import Ember from 'ember';

export default Ember.Controller.extend({

  savedApps: Ember.computed.filterBy('model', 'isNew', false),

  sortBy: ['name'],
  orderedApps: Ember.computed.sort('savedApps', 'sortBy'),

  newApp: function() {
    return  this.get('model').filterBy('isNew', true).get('firstObject');
  }.property('model.@each.isNew'),

  actions: {
    createApp: function() {
      if (!this.get('newApp')) {
        this.store.createRecord('app');
      }
    }
  }
});
