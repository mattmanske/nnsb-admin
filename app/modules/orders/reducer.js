//-----------  Imports  -----------//

import orderBy    from 'lodash/orderBy'
import groupBy    from 'lodash/groupBy'

import { AUTH }   from 'modules/auth/actions'

import { ORDERS } from './actions'

//-----------  Definitions  -----------//

const initialState = {
  data      : {},
  error     : null,
  hasMore   : false,
  isLoading : false,
}

//-----------  Reducers  -----------//

function ordersReducer(state = initialState, action){
  let { data, hasMore, error } = action

  data = orderBy(data, ['created'], ['desc'])
  data = groupBy(data, 'status')

  switch (action.type){

    case AUTH.SYNC:
    case ORDERS.SHIP:
    case ORDERS.REQUEST:
      return { ...state, isLoading: true }

    case ORDERS.SUCCESS:
      return { ...initialState, data, hasMore }

    case AUTH.SIGNOUT:
    case ORDERS.FAILURE:
      return { ...initialState, error }

    default:
      return state
  }
}

//-----------  Exports  -----------//

export default ordersReducer
