#-----------  Requirements  -----------#

_               = require('underscore')
moment          = require('moment')
assign          = require('object-assign')
Firebase        = require('firebase')
EventEmitter    = require('events').EventEmitter

Constants       = require('./../constants/constants')
TableDispatcher = require('./../dispatchers/table_dispatcher')

ActionTypes     = Constants.ActionTypes
CHANGE_EVENT    = 'change'

#-----------  Module  -----------#

Store = assign {}, EventEmitter.prototype,

  _shows             : []
  _members           : {}
  _visibleShows      : []
  _visibleTaxes      : []
  _visibleDeductions : []

  _showsDB   : new Firebase('https://nnsb-calculator.firebaseio.com/shows/')
  _membersDB : new Firebase('https://nnsb-calculator.firebaseio.com/members/')

  _default_show : {
    date         : null
    name         : null
    payment      : 0
    booked_by    : 0
    participants : []
    is_paid      : false
    is_taxed     : false
    milage       : 0
    vehicles     : 0
  }

  #-----------  Initializer  -----------#

  init: ->
    @_showsDB.on 'value', (data) => return @_showsUpdated(data)
    @_membersDB.on 'value', (data) => return @_membersUpdated(data)
    @_setShowFilters(moment().startOf('month'))

  #-----------  Update Handlers  -----------#

  _showsUpdated: (fire_data) ->
    @_shows = _.map(fire_data.val(), (show, id) -> return _.extend(show, {id: id}))
    @_setShowFilters()
    @_emitChange()

  _membersUpdated: (fire_data) ->
    @_members = fire_data.val()
    @_emitChange()

  #-----------  Setters  -----------#

  _setShowFilters: (filter_month = null) ->
    @_filteredMonth = filter_month || @_filteredMonth
    filter_year     = @_filteredMonth.year()

    filtered_shows = _.filter(@_shows, (show) =>
      return moment(show.date).isSame(@_filteredMonth, 'month')
    )
    filtered_taxes = _.filter(@_shows, (show) =>
      return moment(show.date).isSame(@_filteredMonth, 'year')
    )
    filtered_deductions = _.filter(@_shows, (show) =>
      isYear       = moment(show.date).isSame(@_filteredMonth, 'year')
      hasDeduction = show.milage > 0 && show.vehicles > 0
      return (isYear && hasDeduction)
    )

    @_visibleShows      = _.sortBy(filtered_shows, (show) -> return +moment(show.date))
    @_visibleTaxes      = _.sortBy(filtered_taxes, (show) -> return +moment(show.date))
    @_visibleDeductions = _.sortBy(filtered_deductions, (show) -> return +moment(show.date))

  #-----------  Filter Getters  -----------#

  getFilterMonth: ->
    return @_filteredMonth

  getVisibleShows: ->
    return @_visibleShows

  getVisibleTaxes: ->
    return @_visibleTaxes

  getVisibleDeductions: ->
    return @_visibleDeductions

  getShowParticipants: (show_id) ->
    return _.findWhere(@_shows, {id: show_id}).participants || []

  # getNumberPaid: ->
  #   return _.reduce(@getVisibleShows(), ((memo, show) -> return if show.is_paid then (memo + 1) else memo), 0)

  getShowsTotalCollected: ->
    return _.reduce(@getVisibleShows(), ((memo, show) -> return memo + parseInt(show.payment)), 0)

  #-----------  Member Getters  -----------#

  getMembers: ->
    return @_members

  getMemberName: (member_id) ->
    return if @getMembers()[member_id] then @getMembers()[member_id].name else 'LLC'

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

  getLLCPaymentTotal: (member_id = 0) ->
    booking_cut = _.reduce(@_getMemberBookedShows(member_id), (memo, show) =>
      booking_payment = @_getBookedPayment(show)
      return memo + booking_payment
    , 0)

    llc_cut = _.reduce(@getVisibleShows(), (memo, show) =>
      llc_payment = @_getLLCCut(show)
      return memo + llc_payment
    , 0)

    return booking_cut + llc_cut

  #-----------  Calculations  -----------#

  _getBookedPayment: (show) ->
    return 0 if show.booked_by == 0
    percentage = switch
      when show.payment <= 300 then 0.05
      when show.payment <= 1000 then 0.10
      when show.payment > 1000 then 0.15
    return (show.payment * percentage)

  _getLLCCut: (show) ->
    percentage = 0.15
    return (show.payment * percentage)

  _getPlayingPayment: (show) ->
    total_split = show.payment - @_getBookedPayment(show) - @_getLLCCut(show)
    return (total_split / show.participants.length)

  #-----------  Calculation Filters  -----------#

  _getMemberBookedShows: (member_id) ->
    return _.filter(@getVisibleShows(), (show) -> return show.booked_by == member_id) || []

  _getMemberPlayedShows: (member_id) ->
    return _.filter(@getVisibleShows(), (show) -> return _.contains(show.participants, member_id)) || []

  _getMemberParticipatedShows: (member_id) ->
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

  _createShow: (data) ->
    @_showsDB.push(_.defaults(data, @_default_show))

  _updateShow: (show_id, data) ->
    @_showsDB.child(show_id).update(data)

  _deleteShow: (show_id) ->
    @_showsDB.child(show_id).remove()

  _toggleParticipant: (member_id, show_id) ->
    participants = @getShowParticipants(show_id)
    if _.contains(participants, member_id)
      participants = _.without(participants, member_id)
    else
      participants.push(member_id)
    @_showsDB.child(show_id).update({ participants: participants })

  # _toggleIsPaid: (show_id) ->
  #   @_shows[show_id].is_paid = true

  # _toggleAllIsPaid: ->
  #   for id in _.map(@getFilteredShows(), (show) -> return show.id)
  #     @_shows[id].is_paid = true

#----------  Event Dispatchers  -----------#

Store.dispatchToken = TableDispatcher.register (action) ->

  switch action.type

    when ActionTypes.CHANGE_FILTERS
      Store._setShowFilters(action.startDate)
      Store._emitChange()

    when ActionTypes.CREATE_SHOW
      Store._createShow(action.showData)

    when ActionTypes.UPDATE_SHOW
      Store._updateShow(action.showID, action.showData)

    when ActionTypes.DELETE_SHOW
      Store._deleteShow(action.showID)

    when ActionTypes.TOGGLE_PARTICIPANT
      Store._toggleParticipant(action.memberID, action.showID)

    # when ActionTypes.TOGGLE_IS_PAID
    #   confirm = window.confirm('Are you sure? A paid show cannot be reset.')
    #   if confirm
    #     Store._toggleIsPaid(action.showID)
    #     Store._emitChange()

    # when ActionTypes.TOGGLE_ALL_IS_PAID
    #   confirm = window.confirm('Are you sure? A paid show cannot be reset.')
    #   if confirm
    #     Store._toggleAllIsPaid()
    #     Store._emitChange()

#-----------  Export  -----------#

module.exports = Store
