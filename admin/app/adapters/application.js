import ActiveModelAdapter from 'active-model-adapter';

export default ActiveModelAdapter.extend({
  namespace: (window.RAILS_ENV ? window.RAILS_ENV.baseURL + (window.RAILS_ENV.baseURL ? '/' : '' ) : '') + 'api'
});
