import { Model, hasMany, belongsTo } from 'ember-cli-mirage';

export default Model.extend({
  builds: hasMany(),
  liveBuild: belongsTo()
});
