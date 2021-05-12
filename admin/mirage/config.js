export default function() {
  this.namespace = 'api';

  this.get('/host_apps/:id');

  this.get('/apps');
  this.post('/apps');
  this.get('/apps/:id');
  this.put('/apps/:id');
  this.del('/apps/:id');

  this.get('/builds');
  this.get('/builds/:id');

  this.get('/pubkeys');
  this.post('/pubkeys', function(db, request) {
    var data = JSON.parse(request.requestBody).pubkey;
    data.fingerprint = 'A1:B2:C3';
    var model = db.pubkeys.create(data);
    return { pubkey: model };
  });

  this.del('/pubkeys/:id');
}
