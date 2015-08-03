var ActionTypes, CHANGE_EVENT, DataTableStore, EventEmitter, PersistanceLayer, TableConstants, TableDispatcher, assign;

TableConstants = require('./constants/table_constants');

TableDispatcher = require('./dispatchers/table_dispatcher');

PersistanceLayer = require('./utils/persistance_layer');

EventEmitter = require('events').EventEmitter;

assign = require('object-assign');

ActionTypes = DataTableConstants.ActionTypes;

CHANGE_EVENT = 'change';

DataTableStore = assign({}, EventEmitter.prototype, {
  init: function() {
    var data;
    data = new PersistanceLayer();
    return this._setFilters();
  },
  _setFilters: function() {},
  _emitChange: function() {
    return this.emit(CHANGE_EVENT);
  },
  addChangeListener: function(callback) {
    return this.on(CHANGE_EVENT, callback);
  },
  removeChangeListener: function(callback) {
    return this.removeListener(CHANGE_EVENT, callback);
  }
});

DataTableStore.dispatchToken = DataTableDispatcher.register(function(action) {
  switch (action.type) {
    case ActionTypes.CHANGE_FILTERS:
      DataTableStore._setFilters();
      return DataTableStore._emitChange();
  }
});

module.exports = DataTableStore;
