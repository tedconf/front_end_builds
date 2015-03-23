import resolver from './helpers/resolver';
import {
  setResolver
} from 'ember-qunit';
import domAssertions from './helpers/dom-assertions';

setResolver(resolver);
