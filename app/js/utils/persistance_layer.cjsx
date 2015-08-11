# #-----------  Requirements  -----------#

# _        = require('underscore')
# chance   = require('chance').Chance()
# moment   = require('moment')
# Firebase = require('firebase')

# #-----------  Module  -----------#

# PersistanceLayer =

#   _shows   : new Firebase('https://nnsb-calculator.firebaseio.com/shows/')
#   _members : new Firebase('https://nnsb-calculator.firebaseio.com/members/')

#   _default : {
#     date: null
#     name: null
#     payment: 0
#     booked_by: 0
#     participants: []
#     is_paid: false
#   }

#   #-----------  Getters  -----------#

#   getShows: ->
#     return @_shows.once 'value', (data) -> return data

#   getMembers: ->
#     return @_members.once 'value', (data) -> return data

#   #-----------  Setters  -----------#

#   createShow: (data) ->
#     @_shows.push(_.defaults(data, @_default))

#   updateShow: (data) ->
#     false

#   #-----------  Fetchers  -----------#

#   _fetchShows: (number_of_shows) ->
#     shows = []
#     for index in [0...number_of_shows] by 1
#       shows.push {
#         id           : index + 1
#         date         : moment(chance.date({year: 2015}))
#         name         : _.sample(['Capitol Brewery', 'Alchemy', 'Tempest', 'Woodshed Ale House'])
#         payment      : _.sample([250, 350, 600, 1250, 1700, 150, 375, 425, 500])
#         booked_by    : _.sample(['0', '3', '4', '5', '6', '7', '8'])
#         participants : @_generateParticipants()
#         is_paid      : false #_.sample([true, false])
#       }
#     return _.sortBy(shows, (show) -> return show.date)

#   _fetchMembers: ->
#     return [
#       { name: 'Brian', email: 'Zimmerman.Brian.G@gmail.com' }
#       { name: 'Matt', email: 'manske.ma@gmail.com' }
#       { name: 'Ela', email: 'elmowinski@gmail.com' }
#       { name: 'Jeff', email: 'jeff.weiss12@gmail.com' }
#       { name: 'Hannah', email: 'hannahvbenton@gmail.com' }
#       { name: 'Josh P', email: 'josh.pultorak@gmail.com' }
#       { name: 'Chris', email: 'chris.ptasnik@gmail.com' }
#       { name: 'Josh K', email: 'jlemonsk@gmail.com' }
#       { name: 'Terry', email: 'jtgrffn@gmail.com' }
#       { name: 'Bob', email: 'hannahvbenton@gmail.com' }
#     ]

#   #-----------  Generators  -----------#

#   _generateParticipants: ->
#     players = []
#     for index in [1.._.random(3, 9)] by 1
#       players.push _.sample(['1', '2', '3', '4', '5', '6', '7', '8', '9'])
#     return _.uniq(players)

# #-----------  Export  -----------#

# module.exports = PersistanceLayer
