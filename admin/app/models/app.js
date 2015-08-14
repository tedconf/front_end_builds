import DS from 'ember-data';
import Ember from 'ember';

export default DS.Model.extend({
  builds: DS.hasMany('build'),
  liveBuild: DS.belongsTo('build'),

  name: DS.attr('string', {defaultValue: ''}),
  apiKey: DS.attr('string'),
  client: DS.attr('string', {default: 'Web'}),
  location: DS.attr('string'),
  requireManualActivation: DS.attr('boolean'),
  activateNewDeploys: Ember.computed.not('requireManualActivation'),
  
  full_name: function(){
    if(this.get('client')){
      return this.get('name') + '-' + this.get('client');
    }else{
      return this.get('name');
    }
  }.property('name', 'client'),

  buildsSorting: ['createdAt:desc'],
  orderedBuilds: Ember.computed.sort('builds', 'buildsSorting'),
});
