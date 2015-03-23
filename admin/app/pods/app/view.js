import Ember from 'ember';

export default Ember.View.extend({
  _startMatchHeight: function() {
    this.$('.match-height').matchHeight();
  }.on('didInsertElement'),

  _removeMatchHeight: function() {
    this.$('.match-height').matchHeight('remove');
  }.on('willRemoveElement')
});
