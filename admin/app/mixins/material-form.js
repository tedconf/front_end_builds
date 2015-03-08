import Ember from 'ember';

export default Ember.Mixin.create({
  __setupMaterialForm: function() {
    Ember.$.material.input(this.$('input'), this.$('textarea'));
    Ember.$.material.checkbox(this.$('input[type="checkbox"]'));
    Ember.$.material.radio(this.$('input[type="radio"]'));
  }.on('didInsertElement')
});
