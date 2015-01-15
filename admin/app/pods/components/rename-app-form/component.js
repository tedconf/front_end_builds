import Ember from 'ember';
import BufferedProxy from 'ember-buffered-proxy/proxy';

export default Ember.Component.extend({

  proxy: function() {
    return BufferedProxy.create({
      content: this.get('app')
    });
  }.property('app'),

  nameHasChanged: function() {
    return this.get('app.name') !== this.get('proxy.name');
  }.property('app.name', 'proxy.name'),

  actions: {
    dismiss: function() {
      this.sendAction('dismiss');
    },

    renameApp: function() {
      this.get('proxy').applyChanges();
      this.get('app').save().then(() => {
        this.sendAction('dismiss');
      }, () => {
        console.error('something happened');
      });
    }
  }

});
