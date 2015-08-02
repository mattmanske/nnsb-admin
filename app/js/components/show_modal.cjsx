#-----------  Requirements  -----------#

React        = require('react')
moment       = require('moment')
classNames   = require('classnames')
Modal        = require('react-bootstrap-modal')

TableActions = require('./../actions/table_actions')

#-----------  React Componet Class  -----------#

ShowModal = React.createClass

  getDefaultProps: ->
    return {
      show: {}
    }

  getInitialState: ->
    return {
      isModalOpen: false
    }

  #-----------  Event Handlers  -----------#

  _openModal: ->
    @setState({ isModalOpen: true })

  _closeModal: ->
    @setState({ isModalOpen: false })

  _saveAndClose: ->
    TableActions.addNewShow()
    @_closeModal()

  #-----------  HTML Element Render  -----------#

  render: ->
    return (
      <div>
        <button className="btn btn-default" onClick={this._openModal}>Add New Show</button>

        <Modal show={this.state.isModalOpen} onHide={this._closeModal}>
          <button className='btn btn-primary' onClick={this._saveAndClose}>Add Show</button>
        </Modal>
      </div>
    )

#-----------  Export  -----------#

module.exports = ShowModal
