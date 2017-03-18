import Ember from 'ember';
import config from './config/environment';

const Router = Ember.Router.extend({
  location: config.locationType,
  rootURL: config.rootURL
});

Router.map(function() {
  this.route('getting-started');
  this.route('cli');
  this.route('commands', function() {
    this.route('generate');
    this.route('destroy');
    this.route('init');
    this.route('new');
    this.route('test');
    this.route('run');
  });
});

export default Router;
