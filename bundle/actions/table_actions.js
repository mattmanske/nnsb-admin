var ActionTypes, DataTableActions, DataTableConstants, DataTableDispatcher;

DataTableConstants = require('./constants/table_constants');

DataTableDispatcher = require('./dispatchers/table_dispatcher');

ActionTypes = DataTableConstants.ActionTypes;

DataTableActions = {
  changeFilters: function() {
    return DataTableDispatcher.dispatch({
      type: ActionTypes.CHANGE_FILTERS
    });
  }
};

module.exports = DataTableActions;
