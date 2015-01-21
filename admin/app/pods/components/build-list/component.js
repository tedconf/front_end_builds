import Ember from 'ember';

export default Ember.Component.extend({

  actions: {
    activate: function(build) {
      build.set('active', true)
        .save();
    },
    deactivate: function(build) {
      build.set('active', false)
        .save();
    },
  }

});
