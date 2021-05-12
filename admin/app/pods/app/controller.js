import Controller from '@ember/controller';

export default Controller.extend({

  isRenameModalVisible: true,

  actions: {

    startRenamingApp() {
      this.set('isRenamingApp', true);
    },

    stopRenamingApp() {
      this.set('isRenamingApp', false);
    },

    startDeletingApp() {
      this.set('isDeletingApp', true);
    },

    stopDeletingApp() {
      this.set('isDeletingApp', false);
    },

    toggleNewDeploys: function(value) {
      var app = this.get('model');

      app.set('requireManualActivation', !value);
      app.save();
    },

    appDeleted: function() {
      this.set('controller.willDelete', undefined);
      // this.transitionTo('apps');
    }
  }


});
