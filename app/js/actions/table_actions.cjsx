#-----------  Requirements  -----------#

Constants       = require('./../constants/constants')
TableDispatcher = require('./../dispatchers/table_dispatcher')

ActionTypes = Constants.ActionTypes

#-----------  Module  -----------#

TableActions =

  changeFilters: (start_date) ->
    TableDispatcher.dispatch
      type      : ActionTypes.CHANGE_FILTERS
      startDate : start_date

#-----------  Export  -----------#

module.exports = TableActions
