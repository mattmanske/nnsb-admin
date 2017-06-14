//-----------  Imports  -----------//

import { connect }    from 'react-redux'

import DashboardRoute from './DashboardRoute'

//-----------  Redux Maps  -----------//

const mapState = (state) => ({
  orders    : state.orders.data,
  downloads : state.downloads.data
})

const mapDispatch = (dispatch) => ({})

//-----------  Exports  -----------//

export default connect(mapState, mapDispatch)(DashboardRoute)
