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
  createdAt: DS.attr('date'),

  isBest: function() {
    return this.get('id') == this.get('app.bestBuildId');
  }.property('app.bestBuildId'),

  shortSha: function() {
    return this.get('sha').slice(0, 6);
  }.property('sha')
});
