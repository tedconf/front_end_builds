import DS from 'ember-data';

export default DS.Model.extend({
  app: DS.belongsTo('app'),

  sha: DS.attr('string'),
  job: DS.attr('string'),
  branch: DS.attr('string'),
  active: DS.attr('boolean'),
  createdAt: DS.attr('date'),

  isBest: function() {
    return this === this.get('app.bestBuild');
  }.property('app.bestBuild'),

  shortSha: function() {
    return this.get('sha').slice(0, 6);
  }.property('sha')
});
