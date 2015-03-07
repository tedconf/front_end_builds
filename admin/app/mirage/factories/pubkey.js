import Factory from 'ember-cli-mirage/factory';

export default Factory.extend({
  name: 'test key',
  fingerprint: (i) => i
});
