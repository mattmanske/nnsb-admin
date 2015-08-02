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

  _shows   : []
  _members : []

  init: ->
    data = new PersistanceLayer(50)

    @_shows = _.indexBy(data.getShows(), 'id')
    @_members = _.indexBy(data.getMembers(), 'id')
    @_setFilters()

  #-----------  Setters  -----------#

  _setFilters: (filter_start, filter_end) ->
    @_filterStart   = filter_start || moment().startOf('month')
    @_filterEnd     = filter_end || moment(@_filterStart).endOf('month')
    @_filteredShows = _.filter(@_shows, (show) => return show.date.isBetween(@_filterStart, @_filterEnd))

  #-----------  Filter Getters  -----------#

  getFilterMonth: ->
    return @_filterStart

  getFilteredShows: ->
    return @_filteredShows

  getNumberPaid: ->
    return _.reduce(@getFilteredShows(), ((memo, show) -> return if show.is_paid then (memo + 1) else memo), 0)

  getShowsTotalCollected: ->
    return _.reduce(@getFilteredShows(), ((memo, show) -> return memo + show.payment), 0)

  #-----------  Member Getters  -----------#

  getMembers: ->
    return @_members

  getMemberName: (member_id) ->
    return if @getMembers()[member_id] then @getMembers()[member_id].name else 'LLC'

  getMemberShowsTotal: (member_id = '0') ->
    return @_getMemberParticipatedShows(member_id).length

  getMemberPaymentTotal: (member_id = '0') ->
    booking_cut = _.reduce(@_getMemberBookedShows(member_id), (memo, show) =>
      booking_payment = @_getBookedPayment(show)
      return memo + booking_payment
    , 0)

    playing_cut = _.reduce(@_getMemberPlayedShows(member_id), (memo, show) =>
      playing_payment = @_getPlayingPayment(show)
      return memo + playing_payment
    , 0)

    return booking_cut + playing_cut

  #-----------  Calculations  -----------#

  _getBookedPayment: (show) ->
    percentage = switch
      when show.payment <= 500  then 0.1
      when show.payment <= 1200 then 0.2
      when show.payment > 1200  then 0.3
    return (show.payment * percentage)

  _getPlayingPayment: (show) ->
    total_split = show.payment - @_getBookedPayment(show)
    return (total_split / show.participants.length)

  #-----------  Calculation Filters  -----------#

  _getMemberBookedShows: (member_id = '0') ->
    return _.filter(@getFilteredShows(), (show) -> return show.booked_by == member_id) || []

  _getMemberPlayedShows: (member_id = '0') ->
    return _.filter(@getFilteredShows(), (show) -> return _.contains(show.participants, member_id)) || []

  _getMemberParticipatedShows: (member_id = '0') ->
    shows = @_getMemberBookedShows(member_id).concat(@_getMemberPlayedShows(member_id))
    return _.uniq(shows, false, (show) -> return show.id) || []

  #-----------  Change Listeners  -----------#

  _emitChange: ->
    return @emit(CHANGE_EVENT)

  addChangeListener: (callback) ->
    return @on(CHANGE_EVENT, callback)

  removeChangeListener: (callback) ->
    return @removeListener(CHANGE_EVENT, callback)

  #-----------  Event Responders  -----------#

  _toggleIsPaid: (show_id) ->
    @_shows[show_id].is_paid = true

  _toggleAllIsPaid: ->
    for id in _.map(@getFilteredShows(), (show) -> return show.id)
      @_shows[id].is_paid = true

#----------  Event Dispatchers  -----------#

Store.dispatchToken = TableDispatcher.register (action) ->

  switch action.type

    when ActionTypes.CHANGE_FILTERS
      Store._setFilters(action.startDate)
      Store._emitChange()

    when ActionTypes.TOGGLE_IS_PAID
      confirm = window.confirm('Are you sure? A paid show cannot be reset.')
      if confirm
        Store._toggleIsPaid(action.showID)
        Store._emitChange()

    when ActionTypes.TOGGLE_ALL_IS_PAID
      confirm = window.confirm('Are you sure? A paid show cannot be reset.')
      if confirm
        Store._toggleAllIsPaid()
        Store._emitChange()

#-----------  Export  -----------#

module.exports = Store
