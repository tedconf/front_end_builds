import Ember from 'ember';

export default Ember.Route.extend({

  actions: {
    appDeleted: function() {
      this.set('controller.willDelete', undefined);
      this.transitionTo('apps');
    }
  }

});
