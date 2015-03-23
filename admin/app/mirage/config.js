export default function() {
  this.namespace = 'api';

  this.get('/host_apps/:id');

  this.get('/apps', ['apps', 'builds']);
  this.get('/apps/:id', ['app', 'builds']);

  this.post('/apps');

  this.put('/apps/:id');

  this.del('/apps/:id', ['app', 'builds']);

  this.get('/pubkeys');
  this.post('/pubkeys', function(db, request) {
    var data = JSON.parse(request.requestBody).pubkey;
    data.fingerprint = 'A1:B2:C3';
    var model = db.pubkeys.insert(data);
    return { pubkey: model };
  });

  this.del('/pubkeys/:id');
}
