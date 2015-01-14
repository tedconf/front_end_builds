/* global jQuery  */
import Pretender from 'pretender';

import apps from './data/apps';
import builds from './data/builds';

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
var config = function() {
  var _this = this;

  this.stubUrl = function(verb, url, data) {
    this[verb].call(this, '' + url, function(request) {
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

    this.delete('/apps/:id', function(request) {
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

  this.resetGlobalRoutes();
};

export default {
  initialize: function() {
    return new Pretender(config);
  }
};
