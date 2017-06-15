//-----------  Imports  -----------//

import { AUTH }      from 'modules/auth/actions'

import { DOWNLOADS } from './actions'

//-----------  Definitions  -----------//

const initialState = {
  data       : {},
  error      : null,
  isLoading  : false,
  isWatching : false,
}

//-----------  Reducers  -----------//

function downloadsReducer(state = initialState, action){
  let isWatching = true, isLoading = true
  let { data, error } = action

  switch (action.type){

    case AUTH.SYNC:
      return { ...state, isLoading, isWatching }

    case DOWNLOADS.SUCCESS:
      return { ...initialState, data, isWatching }

    case DOWNLOADS.FAILURE:
      return { ...initialState, error, isWatching }

    default:
      return state
  }
}

//-----------  Exports  -----------//

export default downloadsReducer
