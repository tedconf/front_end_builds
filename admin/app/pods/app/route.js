import Ember from 'ember';

export default Ember.Route.extend({

  actions: {
    deleteApp: function() {
      var _this = this;

      return this.get('controller.attrs.app').destroyRecord().then(function() {
        return _this.transitionTo('apps');

      }, function(reason) {

        console.error("deleteApp didn't work");
        console.log(reason);
      });
    }
  }

});
