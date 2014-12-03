module.exports = function(app) {
  var express = require('express');
  var appsRouter = express.Router();
  var apps = [
    {
      id: 1,
      name: 'ted-ed-lesson-creator',
      api_key: '2313123',
      build_ids: [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    },
    {
      id: 2,
      name: 'my-app',
      api_key: 'na23908g',
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
      is_best: i === 10 ? true : false,
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
    var i = req.params.id - 1;
    setTimeout(function() {
      res.send({
        app: apps[i],
        builds: builds
      });
    }, 500);
  });

  appsRouter['delete']('/:id', function(req, res) {
    var appId = +req.params.id;

    var app = apps.filter(function(item) {
      return item.id === appId;
    })[0];
    var i = apps.indexOf(app);
    apps.splice(i, 1);

    builds.filter(function(build) {
      return build.app_id === appId;
    }).forEach(function(build) {
      var index = builds.indexOf(build);
      builds.splice(index, 1);
    });

    setTimeout(function() {
      res.send({});
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

  app.use('/api/apps', appsRouter);
};
