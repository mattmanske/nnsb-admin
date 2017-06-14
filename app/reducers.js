//-----------  Imports  -----------//

import { combineReducers }              from 'redux'
import { reducer as formReducer }       from 'redux-form'
import { LOCATION_CHANGE }              from 'react-router-redux'
import { createResponsiveStateReducer } from 'redux-responsive'
import useragent                        from 'express-useragent'

import authReducer                      from 'modules/auth/reducer'
import modalReducer                     from 'modules/modal/reducer'
import showsReducer                     from 'modules/shows/reducer'
import ordersReducer                    from 'modules/orders/reducer'
import membersReducer                   from 'modules/members/reducer'
import customersReducer                 from 'modules/customers/reducer'
import downloadsReducer                 from 'modules/downloads/reducer'

//-----------  Definitions  -----------//

const routeInitialState = { locationBeforeTransitions: null }

function routeReducer(state = routeInitialState, action){
  switch (action.type){
    case LOCATION_CHANGE:
      return Object.assign({}, state, { locationBeforeTransitions: action.payload })
    default:
      return state
  }
}

function initialMediaType(){
  const ua = new useragent.UserAgent().parse(navigator.userAgent) || {}
  let mediaType = 'large'

  if (ua.isMobile)  mediaType = 'small'
  if (ua.isTablet)  mediaType = 'medium'
  if (ua.isDesktop) mediaType = 'large'

  return mediaType
}

//-----------  Exports  -----------//

export default function createReducer(asyncReducers){
  return combineReducers({
    form      : formReducer,
    auth      : authReducer,
    route     : routeReducer,
    modal     : modalReducer,
    orders    : ordersReducer,
    shows     : showsReducer,
    members   : membersReducer,
    customers : customersReducer,
    downloads : downloadsReducer,
    browser   : createResponsiveStateReducer(null, { initialMediaType: initialMediaType() }),
    ...asyncReducers,
  })
}
