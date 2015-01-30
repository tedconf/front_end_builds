import DS from 'ember-data';

export default DS.Model.extend({
  app: DS.belongsTo('app', {inverse: 'builds'}),

  sha: DS.attr('string'),
  job: DS.attr('string'),
  branch: DS.attr('string'),
  createdAt: DS.attr('date'),

  isLive: function() {
    return this === this.get('app.liveBuild');
  }.property('app.liveBuild'),

  activate: function() {
    return this.get('app').set('liveBuild', this).save();
  },

  shortSha: function() {
    return this.get('sha').slice(0, 6);
  }.property('sha'),

  location: function() {
    var base = this.get('app.location');
    var isLive = this.get('isLive');
    var sha = this.get('sha');

    return isLive ? base : `${base}?sha=${sha}`;
  }.property('app.location', 'isLive', 'sha')
});
