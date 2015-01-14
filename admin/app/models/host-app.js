import DS from 'ember-data';

export default DS.Model.extend({
  apps: DS.hasMany('app'),

  name: DS.attr('string'),
  friendlyName: function() {
    return this.get('name').replace('_', ' ').capitalize();
  }.property('name')
});
