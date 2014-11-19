import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  apiKey: DS.attr('string'),

  builds: DS.hasMany('build'),

  bestBuild: function() {
    return this.get('builds').findBy('isBest');
  }.property('builds.@each.isBest')
});
