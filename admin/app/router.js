import EmberRouter from '@ember/routing/router';
import config from './config/environment';

const Router = EmberRouter.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('apps', { path: '/' });

  this.route('app', { path: '/apps/:app_id' }, function() {
    // this.modal('delete-app-form', {
    //   withParams: ['willDelete'],
    //   otherParams: {
    //     model: 'app'
    //   },
    //   actions: {deleted: 'appDeleted'}
    // });

    // this.modal('rename-app-form', {
    //   withParams: ['willRename'],
    //   otherParams: {
    //     model: 'app'
    //   }
    // });
  });

  this.route("pubkeys", { path: '/ssh-keys' }, function() {
    // this.modal('delete-pubkey-modal', {
    //   withParams: ['willDelete'],
    //   otherParams: {
    //     pubkey: "pubkey"
    //   },
    //   actions: {
    //     removeAction: 'remove',
    //   }
    // });
  });
});

export default Router;
