module.exports = function(app) {
  var express = require('express');
  var appsRouter = express.Router();
  var apps = [
    {
      id: 1,
      name: 'first-app',
      api_key: '2313123'
    }
  ];

  appsRouter.get('/', function(req, res) {
    res.send({"apps":apps});
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
