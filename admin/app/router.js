import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType,
  baseURL: window.RAILS_ENV.baseURL
});

Router.map(function() {
  this.resource('apps', {path: '/'});
  this.resource('app', {path: '/:app_id'}, function() {
    this.modal('delete-app-form', {
      withParams: ['willDelete'],
      otherParams: {
        model: 'app'
      },
      actions: {deleted: 'appDeleted'}
    })
  });
});

export default Router;
