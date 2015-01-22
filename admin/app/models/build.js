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
  }.property('sha'),

  location: function() {
    var base = this.get('app.location');
    var isBest = this.get('isBest');
    var sha = this.get('sha');

    return isBest ? base : `${base}?sha=${sha}`;
  }.property('app.location', 'isBest', 'sha')
});
