import DS from 'ember-data';
const { attr, belongsTo, hasMany } = DS;
import { computed } from '@ember/object';

import { validator, buildValidations } from 'ember-cp-validations';

const Validations = buildValidations({
  name: validator('presence', true),
});

export default DS.Model.extend(Validations, {
  builds: hasMany('build'),
  liveBuild: belongsTo('build'),

  name: attr('string', {defaultValue: ''}),
  apiKey: attr('string'),
  location: attr('string'),

  requireManualActivation: attr('boolean'),
  activateNewDeploys: computed.not('requireManualActivation'),

  buildsSorting: Object.freeze(['createdAt:desc']),
  orderedBuilds: computed.sort('builds', 'buildsSorting'),
});
