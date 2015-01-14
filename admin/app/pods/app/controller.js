import Ember from 'ember';

export default Ember.Controller.extend({
  actions: {
    willDeleteApp: function() {
      this.set('willDelete', true);
    }
  }
});
