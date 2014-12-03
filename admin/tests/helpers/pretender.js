/* global jQuery  */
import Pretender from 'pretender';

import apps from './stub-data/apps';
import builds from './stub-data/builds';

var stubData = {
  apps: apps,
  builds: builds,
};

// by default allow logging in
stubData.validLogin = true;

stubData.currentUser = {
  email: "sam.selikoff@gmail.com",
  firstname: "Sam",
  id: "current",
  lastname: "Selikoff"
};

/*
*/
var pretender = new Pretender(function() {
  var _this = this;

  this.stubUrl = function(verb, url, data) {
    this[verb].call(this, '/api' + url, function(request) {
      console.log('Hitting ' + url);
      console.log(data);
      return [200, {}, JSON.stringify(data)];
    });
  }.bind(this);

  this.unhandledRequest = function(verb, path, request) {
    console.error("FAILED REQUEST");
    console.error(verb, path);
  };

  this.setupGlobalRoutes = function(data) {
    var _this = this;

    this.stubUrl('get', '/apps', {
      apps: data.apps,
      builds: data.builds
    });

    this.stubUrl('get', '/apps/:id', {
      app: data.apps[0],
      builds: data.builds
    });

    this.stubUrl('post', '/apps', {});

    this.delete('/api/apps/:id', function(request) {
      var appId = +request.params.id;
      data.apps = data.apps.rejectBy('id', appId);
      data.builds = data.builds.rejectBy('app_id', appId);

      _this.setupGlobalRoutes.call(_this, data);

      return [204, {}];
    });

  }.bind(this);

  this.resetGlobalRoutes = function() {
    var data = jQuery.extend(true, {}, stubData); // Make sure we have a copy

    this.setupGlobalRoutes(data);
  };

});

export default pretender;
