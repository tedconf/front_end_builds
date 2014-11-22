module.exports = function(app) {
  var express = require('express');
  var appsRouter = express.Router();
  var apps = [
    {
      id: 1,
      name: 'ted-ed-lesson-creator',
      api_key: '2313123',
      build_ids: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }
  ];
  var builds = [];
  for (var i = 1; i < 11; i++) {
    builds.push({
      id: i,
      app_id: 1,
      sha: Math.floor(Math.random()*100000),
      job: i,
      branch: 'master',
      is_best: i === 1 ? true : false,
      created_at: '2014-11-' + (9+i)
    });
  }

  appsRouter.get('/', function(req, res) {
    setTimeout(function() {
      res.send({
        apps: apps,
        builds: builds
      });
    }, 500);
  });

  appsRouter.get('/:id', function(req, res) {
    setTimeout(function() {
      res.send({
        app: apps[0],
        builds: builds
      });
    }, 500);
  });

  appsRouter.post('/', function(req, res) {
    var newIndex = apps.length + 1;
    var data = {
      id: newIndex,
      name: req.body.app.name,
      api_key: 'blk24b3l4kjsfbabc'
    };

    setTimeout(function() {
      res.send({"app":data});
    }.bind(this), 500);
  });

  app.use('/apps', appsRouter);
};
