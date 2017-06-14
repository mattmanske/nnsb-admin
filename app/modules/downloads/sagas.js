//-----------  Imports  -----------//

import { takeLatest }             from 'redux-saga'
import { put, take, call }        from 'redux-saga/effects'

import { RSF_SITE, timestamp }    from 'modules/helpers'
import { AUTH }                   from 'modules/auth/actions'

import { DOWNLOADS, sagaActions } from './actions'

//-----------  Sagas  -----------//

function* syncDownloadsSaga(){
  const channel = yield call(RSF_SITE.channel, 'downloads')

  while(true){
    const data = yield take(channel)

    if (data) yield put(sagaActions.success(data))
    else yield put(sagaActions.failure())
  }
}


//-----------  Watchers  -----------//

export default function* downloadsSagas(){
  yield [
    takeLatest(AUTH.SUCCESS, syncDownloadsSaga)
  ]
}
