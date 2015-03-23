import Ember from 'ember';
import config from './config/environment';

var Router = Ember.Router.extend({
  location: config.locationType
});

Router.map(function() {
  this.resource('apps', { path: '/' });

  this.resource('app', { path: '/apps/:app_id' }, function() {
    this.modal('delete-app-form', {
      withParams: ['willDelete'],
      otherParams: {
        model: 'app'
      },
      actions: {deleted: 'appDeleted'}
    });

    this.modal('rename-app-form', {
      withParams: ['willRename'],
      otherParams: {
        model: 'app'
      }
    });
  });

  this.resource("pubkeys", { path: '/ssh-keys' }, function() {
    this.modal('delete-pubkey-modal', {
      withParams: ['willDelete'],
      otherParams: {
        pubkey: "pubkey"
      },
      actions: {
        removeAction: 'remove',
      }
    });
  });
});

export default Router;
