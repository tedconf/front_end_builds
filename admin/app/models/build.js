import DS from 'ember-data';

export default DS.Model.extend({
  app: DS.belongsTo('app'),

  sha: DS.attr('string'),
  job: DS.attr('string'),
  branch: DS.attr('string'),
  html: DS.attr('string'),
  fetched: DS.attr('boolean'),
  active: DS.attr('boolean'),
  endpoint: DS.attr('string'),

  isBest: DS.attr('boolean')
});
