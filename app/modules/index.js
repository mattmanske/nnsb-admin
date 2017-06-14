//-----------  Imports  -----------//

import { fork, join } from 'redux-saga/effects'

import authSagas      from 'modules/auth/sagas'
import showsSagas     from 'modules/shows/sagas'
import ordersSagas    from 'modules/orders/sagas'
import membersSagas   from 'modules/members/sagas'
import customersSagas from 'modules/customers/sagas'
import downloadsSagas from 'modules/downloads/sagas'

//-----------  Wait All  -----------//

export const waitAll = (sagas) => function* genTasks(){
  const tasks = yield sagas.map(([saga, ...params]) => fork(saga, ...params))
  yield tasks.map(join)
}

//-----------  Exports  -----------//

export default function* rootSaga(){
  yield [
    authSagas(),
    showsSagas(),
    ordersSagas(),
    membersSagas(),
    customersSagas(),
    downloadsSagas()
  ]
}
