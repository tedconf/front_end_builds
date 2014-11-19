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

// pretender
var pretender = new Pretender(function() {
  var _this = this;

  this.stubUrl = function(verb, url, data) {
    console.log(data);
    this[verb].call(this, url, function(request) {
      return [200, {}, JSON.stringify(data)];
    });
  }.bind(this);

  this.resetData = function() {
    this.data = jQuery.extend(true, {}, stubData);
  };

  this.resetData();

  this.unhandledRequest = function(verb, path, request) {
    console.error("FAILED REQUEST");
    console.error(verb, path);
  };

  /*
    Routes
  */
  this.stubUrl('get', '/apps', {
    apps: this.data.apps,
    builds: this.data.builds
  });

});

export default pretender;
