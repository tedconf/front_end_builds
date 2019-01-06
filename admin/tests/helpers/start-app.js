import Application from '../../app';
import config from '../../config/environment';
import { merge } from '@ember/polyfills';
import { run } from '@ember/runloop';

export default function startApp(attrs) {
  var application;

  var attributes = merge({}, config.APP);
  attributes = merge(attributes, attrs); // use defaults, but you can override;

  run(function() {
    application = Application.create(attributes);
    application.setupForTesting();
    application.injectTestHelpers();
  });

  return application;
}
