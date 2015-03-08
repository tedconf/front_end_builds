/* global require, module */

var EmberApp = require('ember-cli/lib/broccoli/ember-app');

var app = new EmberApp({
  fingerprint: {
    prepend: '/front_end_builds/'
  },
  emberCliFontAwesome: { includeFontAwesomeAssets: false }
});

app.import("bower_components/bootstrap/dist/css/bootstrap.css");
app.import("bower_components/bootstrap/dist/js/bootstrap.js");

app.import("bower_components/bootstrap-material-design/dist/css/material.css");
app.import("bower_components/bootstrap-material-design/dist/css/ripples.css");
app.import("bower_components/bootstrap-material-design/dist/js/material.js");
app.import("bower_components/bootstrap-material-design/dist/js/ripples.js");

// Font Awesome
var fonts = [
  "fontawesome-webfont.eot",
  "fontawesome-webfont.svg",
  "fontawesome-webfont.ttf",
  "fontawesome-webfont.woff",
  "fontawesome-webfont.woff2",
  "FontAwesome.otf"
];
var fontDestDir = (app.env === 'production') ? '/assets' : '/front_end_builds/assets/';
fonts.forEach(function(font) {
  app.import('bower_components/font-awesome/fonts/' + font, { destDir: fontDestDir });
});

module.exports = app.toTree();
