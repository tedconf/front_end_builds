import Ember from 'ember';

export default Ember.Component.extend({

  actions: {
    activate: function(build) {
      return build.set('active', true).save().then(null, function(reason) {
        console.error(reason);
      });
    },

    deactivate: function(build) {
      return build.set('active', false).save().then(null, function(reason) {
        console.error(reason);
      });
    },
  }

});
