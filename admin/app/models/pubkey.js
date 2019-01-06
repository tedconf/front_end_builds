import DS from 'ember-data';
const { attr } = DS;
import { computed } from '@ember/object';
import moment from 'moment';

import { validator, buildValidations } from 'ember-cp-validations';

const Validations = buildValidations({
  name: validator('presence', true),
  pubkey: validator('presence', true),
});

export default DS.Model.extend(Validations, {
  name: attr('string'),
  pubkey: attr('string'),
  fingerprint: attr('string'),
  lastUsedAt: attr('date'),

  lastUsedAtFormatted: computed('lastUsedAt', function(){
    return moment(this.get('lastUsedAt')).format('MMM D YYYY');
  })
});
