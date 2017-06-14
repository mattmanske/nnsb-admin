//-----------  Imports  -----------//

import { action, createActionConstants } from 'modules/helpers'

//-----------  Definitions  -----------//

export const DOWNLOADS = createActionConstants('DOWNLOADS')

//-----------  Customers Actions  -----------//

export const downloadsActions = {}

//-----------  Saga Actions  -----------//

export const sagaActions = {
  success: (data) => {
    return action(DOWNLOADS.SUCCESS, { data })
  },
  failure: (error = null) => {
    return action(DOWNLOADS.FAILURE, { error })
  }
}
