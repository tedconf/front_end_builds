import DS from 'ember-data';

export default DS.Model.extend({
  hostApp: DS.belongsTo('hostApp'),
  builds: DS.hasMany('build'),

  name: DS.attr('string', {defaultValue: ''}),
  apiKey: DS.attr('string'),

  bestBuild: function() {
    return this.get('builds').findBy('isBest');
  }.property('builds.@each.isBest')
});
