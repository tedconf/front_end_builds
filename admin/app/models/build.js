import DS from 'ember-data';
const { attr, belongsTo } = DS;
import { computed } from '@ember/object';
import moment from 'moment';

export default DS.Model.extend({
  app: belongsTo('app', {inverse: 'builds'}),

  sha: attr('string'),
  job: attr('string'),
  branch: attr('string'),
  createdAt: attr('date'),

  createdAtFormatted: computed('createdAt', function(){
    let createdAt = this.get('createdAt');
    return `${moment(createdAt).fromNow()} (${moment(createdAt).format('MMM D YYYY')})`;
  }),

  isLive: computed('app.liveBuild', function() {
    return this.get('id') === this.get('app.liveBuild.id');
  }),

  shortSha: computed('sha', function() {
    return this.get('sha') ? this.get('sha').slice(0, 7) : '';
  }),

  location: computed('app.location', 'isLive', 'id', function() {
    var base = this.get('app.location');
    var isLive = this.get('isLive');
    var id = this.get('id');

    return isLive ? base : `${base}?id=${id}`;
  }),

  locationBranch: computed('app.location', 'isLive', 'branch', function() {
    var base = this.get('app.location');
    var isLive = this.get('isLive');
    var branch = this.get('branch');

    return isLive ? base : `${base}?branch=${branch}`;
  })
});
