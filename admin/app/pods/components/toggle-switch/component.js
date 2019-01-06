import Component from '@ember/component';

export default Component.extend({
  classNames: Object.freeze(['Toggle-switch']),
  action: null,
  value: null,

  actions: {
    toggle: function() {
      this.action(!this.get('value'));
    }
  }
});
