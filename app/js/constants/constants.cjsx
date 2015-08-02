#-----------  Requirements  -----------#

KeyMirror = require('keymirror')

#-----------  Module  -----------#

Constants =

  ActionTypes: KeyMirror(
    CHANGE_FILTERS: null
    TOGGLE_IS_PAID: null
    TOGGLE_ALL_IS_PAID: null
  )

#-----------  Export  -----------#

module.exports = Constants