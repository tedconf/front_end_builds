import Ember from 'ember';

export default Ember.Mixin.create({
  __setupMaterialForm: function() {
    Ember.$.material.ripples(this.$('input'));
    Ember.$.material.input(this.$('input'));
    Ember.$.material.checkbox(this.$('input[type="checkbox"]'));
    Ember.$.material.radio(this.$('input[type="radio"]'));
  }.on('didInsertElement')
});
