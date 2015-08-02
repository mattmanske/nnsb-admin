#-----------  Requirements  -----------#

moment       = require('moment')
assign       = require('object-assign')
EventEmitter = require('events').EventEmitter

Constants        = require('./../constants/constants')
TableDispatcher  = require('./../dispatchers/table_dispatcher')
PersistanceLayer = require('./../utils/persistance_layer')

ActionTypes  = Constants.ActionTypes
CHANGE_EVENT = 'change'

#-----------  Module  -----------#

TableStore = assign {}, EventEmitter.prototype,

  init: ->
    data = new PersistanceLayer()

  #-----------  Setters  -----------#

  _setFilters: (filter_start, filter_end) ->
    @_filterStart = filter_start || @moment().startOd('month')
    @_filterEnd   = filter_end || @getFilterMonth().endOf('month')

  #-----------  Getters  -----------#

  getFilterMonth: ->
    return @_filterStart

  getMembers: ->
    return [
      { id: 1, name: 'Brian', email: '' }
      { id: 2, name: 'Matt', email: '' }
      { id: 3, name: 'Ela', email: '' }
      { id: 4, name: 'Jeff', email: '' }
      { id: 5, name: 'Hannah', email: '' }
      { id: 6, name: 'Josh P.', email: '' }
      { id: 7, name: 'Chris.', email: '' }
      { id: 8, name: 'Josh K.', email: '' }
      { id: 9, name: 'Terry', email: '' }
    ]

  getFilteredShows: ->
    return [
      { id: 1, date: '2015-08-01', name: 'Alchemy', payment: '$500', booked_by: null }
      { id: 2, date: '2015-08-02', name: 'Alchemy', payment: '$600', booked_by: 3 }
      { id: 3, date: '2015-08-03', name: 'Alchemy', payment: '$700', booked_by: 6 }
      { id: 4, date: '2015-08-04', name: 'Alchemy', payment: '$800', booked_by: null }
      { id: 5, date: '2015-08-05', name: 'Alchemy', payment: '$900', booked_by: 8 }
    ]

  #-----------  Change Listeners  -----------#

  _emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)

#----------  Event Dispatchers  -----------#

TableStore.dispatchToken = TableDispatcher.register (action) ->

  switch action.type

    when ActionTypes.CHANGE_FILTERS
      TableStore._setFilters(action.startDate)
      TableStore._emitChange()

#-----------  Export  -----------#

module.exports = TableStore
