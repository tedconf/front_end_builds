import Ember from 'ember';

export default Ember.Component.extend({

  actions: {
    activate: function(build) {
      return build.activate().then(null, function(reason) {
        console.error(reason);
      });
    }
  }

});
