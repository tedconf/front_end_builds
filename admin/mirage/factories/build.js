import { Factory } from 'ember-cli-mirage';

export default Factory.extend({
  branch: 'master',
  sha: (i) => `asdf${i}`
});
