import DS from 'ember-data';

export default DS.Model.extend({
  name: DS.attr('string'),
  pubkey: DS.attr('string'),
  fingerprint: DS.attr('string'),
  lastUsedAt: DS.attr('date')
});
