export default function() {

  this.namespace = 'api';


  this.stub('get', '/host_apps/current', function(store, request) {
    return {
      host_app: store.find('hostApps')[0]
    };
  });

  this.stub('get', '/apps', ['apps', 'builds']);
  this.stub('get', '/apps/:id', ['app', 'builds']);

  this.stub('post', '/apps');

  this.stub('put', '/apps/:id');

  this.stub('delete', '/apps/:id', ['app', 'builds']);


  /*
    Routes
  */
  /*
    GET shorthands

    // Collections
    this.stub('get', '/contacts');
    this.stub('get', '/contacts', 'users');
    this.stub('get', '/contacts', ['contacts', 'addresses']);

    // Single objects
    this.stub('get', '/contacts/:id');
    this.stub('get', '/contacts/:id', 'user');
    this.stub('get', '/contacts/:id', ['contact', 'addresses']);
  */

  /*
    POST shorthands

    this.stub('post', '/contacts');
    this.stub('post', '/contacts', 'user'); // specify the type of resource to be created
  */

  /*
    PUT shorthands

    this.stub('put', '/contacts/:id');
    this.stub('put', '/contacts/:id', 'user'); // specify the type of resource to be updated
  */

  /*
    DELETE shorthands

    this.stub('delete', '/contacts/:id');
    this.stub('delete', '/contacts/:id', 'user'); // specify the type of resource to be deleted

    // Single object + related resources. Make sure parent resource is first.
    this.stub('delete', '/contacts/:id', ['contact', 'addresses']);
  */

  /*
    Function fallback. Manipulate data in the store via

      - store.find(key)
      - store.find(key, id)-
      - store.push(key, data)
      - store.delete(key, id)

    // Example: return a single object with related models
    this.stub('get', '/contacts/:id', function(store, request) {
      var contactId = +request.params.id;
      var contact = store.find('contact', contactId);
      var addresses = store.find('address')
        .filterBy('contact_id', contactId);

      return {
        contact: contact,
        addresses: addresses
      };
    });

  */
}
