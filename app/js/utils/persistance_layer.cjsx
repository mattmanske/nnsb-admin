#-----------  Requirements  -----------#

_        = require('underscore')
chance   = require('chance').Chance()
moment   = require('moment')
Firebase = require('firebase')

#-----------  Module  -----------#

PersistanceLayer =

  _shows   : new Firebase('https://nnsb-calculator.firebaseio.com/shows/')
  _members : new Firebase('https://nnsb-calculator.firebaseio.com/members/')

  #-----------  Getters  -----------#

  getShows: ->
    return @_shows.once 'value', (data) -> return data

  getMembers: ->
    return @_members.once 'value', (data) -> return data

  #-----------  Setters  -----------#

  createShow: (data) ->
    default_show = { date: null, name: null, payment: 0, booked_by: 0, participants: [], is_paid: false }
    @_shows.push(_.defaults(data, default_show))

  updateShow: (data) ->
    false

  #-----------  Fetchers  -----------#

  _fetchShows: (number_of_shows) ->
    shows = []
    for index in [0...number_of_shows] by 1
      shows.push {
        id           : index + 1
        date         : moment(chance.date({year: 2015}))
        name         : _.sample(['Capitol Brewery', 'Alchemy', 'Tempest', 'Woodshed Ale House'])
        payment      : _.sample([250, 350, 600, 1250, 1700, 150, 375, 425, 500])
        booked_by    : _.sample(['0', '3', '4', '5', '6', '7', '8'])
        participants : @_generateParticipants()
        is_paid      : false #_.sample([true, false])
      }
    return _.sortBy(shows, (show) -> return show.date)

  _fetchMembers: ->
    return [
      { id: '1', name: 'Brian', email: '' }
      { id: '2', name: 'Matt', email: '' }
      { id: '3', name: 'Ela', email: '' }
      { id: '4', name: 'Jeff', email: '' }
      { id: '5', name: 'Hannah', email: '' }
      { id: '6', name: 'Josh P', email: '' }
      { id: '7', name: 'Chris', email: '' }
      { id: '8', name: 'Josh K', email: '' }
      { id: '9', name: 'Terry', email: '' }
    ]

  #-----------  Generators  -----------#

  _generateParticipants: ->
    players = []
    for index in [1.._.random(3, 9)] by 1
      players.push _.sample(['1', '2', '3', '4', '5', '6', '7', '8', '9'])
    return _.uniq(players)

#-----------  Export  -----------#

module.exports = PersistanceLayer
