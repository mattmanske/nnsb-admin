#-----------  Requirements  -----------#

_            = require('underscore')
moment       = require('moment')
assign       = require('object-assign')
EventEmitter = require('events').EventEmitter

Constants        = require('./../constants/constants')
TableDispatcher  = require('./../dispatchers/table_dispatcher')
PersistanceLayer = require('./../utils/persistance_layer')

ActionTypes  = Constants.ActionTypes
CHANGE_EVENT = 'change'

#-----------  Module  -----------#

Store = assign {}, EventEmitter.prototype,

  init: ->
    @_shows = new PersistanceLayer(300)
    @_setFilters()

  #-----------  Setters  -----------#

  _setFilters: (filter_start, filter_end) ->
    @_filterStart = filter_start || moment().startOf('month')
    @_filterEnd   = filter_end || moment(@_filterStart).endOf('month')

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
      { id: 7, name: 'Chris', email: '' }
      { id: 8, name: 'Josh K.', email: '' }
      { id: 9, name: 'Terry', email: '' }
    ]

  getFilteredShows: ->
    return _.filter @_shows, (show) => show.date.isBetween(@_filterStart, @_filterEnd)

  #-----------  Change Listeners  -----------#

  _emitChange: ->
    @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    @removeListener(CHANGE_EVENT, callback)

#----------  Event Dispatchers  -----------#

Store.dispatchToken = TableDispatcher.register (action) ->

  switch action.type

    when ActionTypes.CHANGE_FILTERS
      Store._setFilters(action.startDate)
      Store._emitChange()

#-----------  Export  -----------#

module.exports = Store
