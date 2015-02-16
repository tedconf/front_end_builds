import Ember from 'ember';

export default Ember.Controller.extend({
  pubkeys: null,
  newPubkey: null,

  displayableKeys: Ember.computed.filterBy('pubkeys', 'id'),
  hasKeys: Ember.computed.gt('displayableKeys.length', 0)
});
