import { Factory } from 'ember-cli-mirage';

export default Factory.extend({
  name: 'test key',
  fingerprint: (i) => i
});
