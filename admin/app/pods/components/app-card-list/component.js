import Ember from 'ember';

export default Ember.Component.extend({

  handleCancelNewApp: function(app) {
    app.deleteRecord();
  }

});
