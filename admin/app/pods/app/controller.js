import Ember from 'ember';

export default Ember.Controller.extend({

  actions: {

    willRenameApp: function() {
      this.set('willRename', true);
    },

    willDeleteApp: function() {
      this.set('willDelete', true);
    }

  }

});
