import DS from 'ember-data';
import Ember from 'ember';

export default DS.Model.extend({
  builds: DS.hasMany('build'),
  liveBuild: DS.belongsTo('build'),

  name: DS.attr('string', {defaultValue: ''}),
  apiKey: DS.attr('string'),
  location: DS.attr('string'),
  requireManualActivation: DS.attr('boolean'),

  buildsSorting: ['createdAt:desc'],
  orderedBuilds: Ember.computed.sort('builds', 'buildsSorting'),
});
