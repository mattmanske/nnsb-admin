//-----------  Imports  -----------//

import Dashboard            from './styles'

import Anytime              from './assets/anytime.jpg'
import Nnsb                 from './assets/nnsb.jpg'
import Meh                  from './assets/meh.jpg'

import keys                 from 'lodash/keys'

import React, { PropTypes } from 'react'

import BoundsWrapper        from 'components/BoundsWrapper'

import CustomersTable       from 'containers/CustomersTable'

//-----------  Definitions  -----------//

const title = 'Dashboard'
const albums = [{
  id    : 'anytime',
  title : 'Anytime',
  cover : Anytime,
},{
  id    : 'meh',
  title : 'MEH',
  cover : Meh,
},{
  id    : 'nnsb',
  title : 'NNSB',
  cover : Nnsb,
}]

//-----------  Component  -----------//

class DashboardRoute extends React.Component {

  //-----------  Helpers  -----------//

  getOrders = (id) => {
    const { orders } = this.props

    return ('meh' == id) ? 2 : 0
  }

  getDownloads = (id, type) => {
    const { downloads } = this.props
    const collection = downloads[id] && downloads[id][type]

    if (!collection) return 0

    return keys(collection).length + parseInt(collection.buffer) - 1
  }

  //-----------  HTML Render  -----------//

  render(){
    return (
      <Dashboard.Page title={title}>
        <BoundsWrapper>
          <Dashboard.Albums>
            <h3>Albums</h3>
            {albums.map(album => (
              <Dashboard.Album key={album.title}>
                <img src={album.cover} />
                <h4>{album.title}</h4>
                <div>
                  <strong>CD Orders: </strong>{this.getOrders(album.id)}
                </div>
                <div>
                  <strong>WAV Downloads: </strong>{this.getDownloads(album.id, 'wav')}
                </div>
                <div>
                  <strong>MP3 Downloads: </strong>{this.getDownloads(album.id, 'mp3')}
                </div>
              </Dashboard.Album>
            ))}
          </Dashboard.Albums>

          <Dashboard.Customers>
            <h3>Customers</h3>
            <CustomersTable />
          </Dashboard.Customers>
        </BoundsWrapper>
      </Dashboard.Page>
    )
  }
}

//-----------  Prop Types  -----------//

DashboardRoute.propTypes = {
  orders    : PropTypes.object.isRequired,
  downloads : PropTypes.object.isRequired
}

//-----------  Exports  -----------//

export default DashboardRoute
