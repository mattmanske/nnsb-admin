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
    data = new PersistanceLayer(3)
    @_shows = data.getShows()
    @_members = data.getMembers()
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

  getShowsTotalCollected: ->
    return _.reduce(@getFilteredShows(), ((memo, show) -> return memo + show.payment), 0)

  #-----------  Member Getters  -----------#

  getMembers: ->
    return @_members

  getMemberName: (member_id) ->
    member = _.findWhere(@getMembers(), {id: member_id})
    return if member then member.name else 'LLC'

  getMemberShowsTotal: (member_id = 0) ->
    return @_getMemberParticipatedShows(member_id).length

  getMemberPaymentTotal: (member_id = 0) ->
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

  _getMemberBookedShows: (member_id = 0) ->
    return _.filter(@getFilteredShows(), (show) -> return show.booked_by == member_id) || []

  _getMemberPlayedShows: (member_id = 0) ->
    return _.filter(@getFilteredShows(), (show) -> return _.contains(show.participants, member_id)) || []

  _getMemberParticipatedShows: (member_id = 0) ->
    shows = @_getMemberBookedShows(member_id).concat(@_getMemberPlayedShows(member_id))
    return _.uniq(shows, false, (show) -> return show.id) || []

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
