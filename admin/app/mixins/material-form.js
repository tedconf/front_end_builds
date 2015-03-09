import Ember from 'ember';

export default Ember.Mixin.create({
  __setupMaterialForm: function() {
    Ember.$.material.input(
      this.$('input.form-control'),
      this.$('textarea.form-control')
    );
    Ember.$.material.togglebutton(this.$('.togglebutton input[type="checkbox"]'));
    Ember.$.material.checkbox(this.$('.checkbox input[type="checkbox"]'));
    Ember.$.material.radio(this.$('input[type="radio"]'));
  }.on('didInsertElement')
});
