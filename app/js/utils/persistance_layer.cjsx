#-----------  Requirements  -----------#

_      = require('underscore')
chance = require('chance').Chance()
moment = require('moment')

#-----------  Module  -----------#

class PersistanceLayer

  _shows: []

  constructor: (number_of_shows) ->
    @_generateShows(number_of_shows)
    return @_sortShows()

  #-----------  Generators  -----------#

  _generateShows: (number_of_shows) ->
    for index in [1...number_of_shows] by 1
      @_shows.push {
        id        : index
        date      : moment(chance.date({year: 2015}))
        name      : _.sample(['Capitol Brewery', 'Alchemy', 'Tempest', 'Woodshed Ale House'])
        pay       : _.sample([250, 350, 600, 1250, 1700, 150, 375, 425, 500])
        booked_by : _.sample([null, 3, 4, 5, 6, 7, 8])
      }

  _sortShows: ->
    return _.sortBy @_shows, (show) -> return show.date

#-----------  Export  -----------#

module.exports = PersistanceLayer
