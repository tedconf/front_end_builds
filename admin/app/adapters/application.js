import DS from 'ember-data';

export default DS.ActiveModelAdapter.extend({
  namespace: window.RAILS_ENV.baseURL + (window.RAILS_ENV.baseURL ? '/' : '' ) + 'api'
});
