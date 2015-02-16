export default function() {

  this.namespace = 'api';

  this.get('/host_apps/current', function(store, request) {
    return {
      host_app: store.findAll('hostApps')[0]
    };
  });

  this.get('/apps', ['apps', 'builds']);
  this.get('/apps/:id', ['app', 'builds']);

  this.post('/apps');

  this.put('/apps/:id');

  this.del('/apps/:id', ['app', 'builds']);
}
