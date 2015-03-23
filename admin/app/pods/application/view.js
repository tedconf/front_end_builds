import Ember from 'ember';

export default Ember.View.extend({
  setupMaterialDesign: function() {
    Ember.$.material.init();
  }.on('willInsertElement')
});
