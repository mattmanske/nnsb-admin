#-----------  Requirements  -----------#

KeyMirror = require('keymirror')

#-----------  Module  -----------#

Constants =

  ActionTypes: KeyMirror(
    CHANGE_FILTERS: null
    CREATE_SHOW: null
    UPDATE_SHOW: null
    DELETE_SHOW: null
    TOGGLE_PARTICIPANT: null
    TOGGLE_IS_PAID: null
    TOGGLE_ALL_IS_PAID: null
  )

#-----------  Export  -----------#

module.exports = Constants