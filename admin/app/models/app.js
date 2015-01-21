import DS from 'ember-data';

export default DS.Model.extend({
  builds: DS.hasMany('build'),

  name: DS.attr('string', {defaultValue: ''}),
  apiKey: DS.attr('string'),
  location: DS.attr('string'),
  requireManualActivation: DS.attr('boolean'),

  buildsSorting: ['createdAt:desc'],
  orderedBuilds: Ember.computed.sort('builds', 'buildsSorting'),

  bestBuild: function() {
    return this.get('orderedBuilds')
      .filterBy('active')
      .filterBy('branch', 'master')
      .get('firstObject');
  }.property('builds.length', 'builds.@each.active')
});
