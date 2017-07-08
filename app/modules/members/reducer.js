//-----------  Imports  -----------//

import flatMap     from 'lodash/flatMap'

import { AUTH }    from 'modules/auth/actions'

import { MEMBERS } from './actions'

//-----------  Definitions  -----------//

const initialState = {
  data       : [],
  error      : null,
  isLoading  : false,
  isWatching : false,
}

//-----------  Reducers  -----------//

function membersReducer(state = initialState, action){
  let isWatching = true, isLoading = true
  let { data, error } = action

  data = flatMap(data, (member, key) => Object.assign({ key }, member))

  switch (action.type){

    case AUTH.SYNC:
    case MEMBERS.CREATE:
    case MEMBERS.UPDATE:
      return { ...state, isLoading, isWatching }

    case MEMBERS.SUCCESS:
      return { ...initialState, data, isWatching }

    case AUTH.SIGNOUT:
    case MEMBERS.FAILURE:
      return { ...initialState, error, isWatching }

    default:
      return state
  }
}

//-----------  Exports  -----------//

export default membersReducer
