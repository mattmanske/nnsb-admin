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

  toggleParticipant: (member_id, show_id) ->
    TableDispatcher.dispatch
      type     : ActionTypes.TOGGLE_PARTICIPANT
      memberID : member_id
      showID   : show_id

  toggleIsPaid: (show_id) ->
    TableDispatcher.dispatch
      type   : ActionTypes.TOGGLE_IS_PAID
      showID : show_id

  toggleAllIsPaid: ->
    TableDispatcher.dispatch
      type   : ActionTypes.TOGGLE_ALL_IS_PAID

#-----------  Export  -----------#

module.exports = TableActions
