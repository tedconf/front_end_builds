module.exports = function(app) {
  var express = require('express');
  var appsRouter = express.Router();
  var apps = [
    {
      id: 1,
      name: 'first-app',
      api_key: '2313123',
      build_ids: [1]
    }
  ];
  var builds = [
    {
      id: 1,
      app_id: 1,
      sha: '1bc3gdw',
      job: 1,
      branch: 'master',
      is_best: true
    }
  ]

  appsRouter.get('/', function(req, res) {
    res.send({
      apps: apps,
      builds: builds
    });
  });

  appsRouter.post('/', function(req, res) {
    var newIndex = apps.length;
    var data = {
      id: newIndex,
      name: req.name
    }
    res.send({"app":data});
  });

  app.use('/apps', appsRouter);
};
