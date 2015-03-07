import Factory from 'ember-cli-mirage/factory';

export default Factory.extend({
  branch: 'master',
  sha: (i) => `asdf${i}`
});
