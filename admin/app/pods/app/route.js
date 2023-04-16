import Route from '@ember/routing/route';

export default Route.extend({
  model: function(params) {
    return this.store.findRecord('app', params.app_id);
  }
});
