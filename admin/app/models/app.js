import DS from 'ember-data';

export default DS.Model.extend({
  builds: DS.hasMany('build'),

  bestBuildId: DS.attr('string'),
  name: DS.attr('string', {defaultValue: ''}),
  apiKey: DS.attr('string'),

  bestBuild: function() {
    return this.get('builds').findBy('id', this.get('bestBuildId'));
  }.property('builds.@each.isBest', 'bestBuildId')
});
