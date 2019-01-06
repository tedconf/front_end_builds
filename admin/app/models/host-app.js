import DS from 'ember-data';
const { attr } = DS;
import { computed } from '@ember/object';

export default DS.Model.extend({
  name: attr('string'),

  friendlyName: computed('name', function() {
    return this.get('name').replace('_', ' ').capitalize();
  })
});
