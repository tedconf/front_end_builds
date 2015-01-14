import Ember from 'ember';

export default Ember.Component.extend({
  orderedBuildsSortingProps: ['createdAt:desc'],
  orderedBuilds: Ember.computed.sort('builds', 'orderedBuildsSortingProps'),
});
