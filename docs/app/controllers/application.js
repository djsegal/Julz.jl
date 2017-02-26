import Ember from 'ember';

import ENV from 'julz/config/environment';

const { Controller, computed } = Ember;

export default Controller.extend({
  actions: {
    toggleExpandedItem(value, ev) {
      if (this.get('expandedItem') === value) {
        value = null;
      }
      this.set('expandedItem', value);
      ev.stopPropagation();
    }
  },

  expandedItem: computed('currentRouteName', function() {
    if (this.get('currentRouteName').substr(0, 6) === 'layout') {
      return 'layout';
    } else {
      if (this.get('currentRouteName').substr(0, 8) === 'commands') {
        return 'commands';
      } else {
        return '';
      }
    }
  }),

  isProductionEnv: ( ENV.environment === 'production' ),

  commandsExpanded: computed.equal('expandedItem', 'commands'),
  layoutExpanded: computed.equal('expandedItem', 'layout')
});
