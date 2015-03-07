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

  this.get('/pubkeys');
  this.post('/pubkeys', function(store, request) {
    var data = JSON.parse(request.requestBody).pubkey;
    data.fingerprint = 'A1:B2:C3';
    var model = store.push('pubkey', data);
    return model;
  });

  this.del('/pubkeys/:id');
}
