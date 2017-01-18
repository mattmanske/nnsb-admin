#-----------  Requirements  -----------#

React        = require('react/addons')
moment       = require('moment')
classNames   = require('classnames')

TableActions = require('./../actions/table_actions')
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

#-----------  React Componet Class  -----------#

ShowModal = React.createClass

  mixins: [React.addons.LinkedStateMixin]

  propTypes:
    members     : React.PropTypes.object
    currentShow : React.PropTypes.object
    isModalOpen : React.PropTypes.bool
    closeModal  : React.PropTypes.func.isRequired

  getDefaultProps: ->
    return {
      members     : {}
      currentShow : {}
      isModalOpen : false
    }

  componentWillReceiveProps: (new_props) ->
    show = new_props.currentShow
    formatted_date = if show.date then moment(show.date).format('YYYY-MM-DD') else moment().format('YYYY-MM-DD')

    @setState {
      name      : show.name
      date      : formatted_date
      payment   : show.payment
      booked_by : show.booked_by
      milage    : show.milage
      vehicles  : show.vehicles
      is_taxed  : show.is_taxed
    }

  #-----------  Event Handlers  -----------#

  _closeModal: (evt) ->
    if $(evt.target).hasClass('nnsb-modal') || $(evt.target).hasClass('nnsb-modal__close')
      @props.closeModal()

  _toggleTaxed: (evt) ->
    @setState({ is_taxed: !@state.is_taxed })

  _deleteAndClose: ->
    confirm = window.confirm('Are you sure you want to delete this show?')
    if confirm
      TableActions.deleteShow(@props.currentShow.id)
      @props.closeModal()

  _saveAndClose: ->
    show_data = {
      date      : @state.date
      name      : @state.name
      payment   : @state.payment
      booked_by : @state.booked_by
      milage    : @state.milage
      vehicles  : @state.vehicles
      is_taxed  : @state.is_taxed
    }

    if @props.currentShow.id
      TableActions.updateShow(@props.currentShow.id, show_data)
    else
      TableActions.createShow(show_data)

    @props.closeModal()

  #-----------  HTML Element Render  -----------#

  render: ->
    if @props.isModalOpen
      member_options = [<option key="0" value="0">– none –</option>]

      for member_id, member of @props.members
        member_options.push <option key={member_id} value={member_id}>{member.name}</option>

      delete_show = (
        <button type="button" className="btn btn-link" onClick={this._deleteAndClose}>delete</button>
      ) if @props.currentShow.id

      return (
        <ReactCSSTransitionGroup transitionName="nnsb-modal--animation">
          <div className="nnsb-modal" onClick={this._closeModal}>
            <div className="nnsb-modal__block">
              <a className="nnsb-modal__close" onClick={this._closeModal}>&times;</a>

              <form className="form-horizontal">
                <div className="form-group">
                  <label className="col-sm-3 control-label">Date</label>
                  <div className="col-sm-9">
                    <input type="date" className="form-control" valueLink={this.linkState('date')} />
                  </div>
                </div>

                <div className="form-group">
                  <label className="col-sm-3 control-label">Name</label>
                  <div className="col-sm-9">
                    <input type="text" className="form-control" valueLink={this.linkState('name')} />
                  </div>
                </div>

                <div className="form-group">
                  <label className="col-sm-3 control-label">Payment</label>
                  <div className="col-sm-6">
                    <input type="number" className="form-control" valueLink={this.linkState('payment')} />
                  </div>
                  <label className="col-sm-1 control-label">W9</label>
                  <div className="col-sm-2">
                    <input type="checkbox" checked={this.state.is_taxed} onChange={this._toggleTaxed} />
                  </div>
                </div>

                <div className="form-group">
                  <label className="col-sm-3 control-label">Booker</label>
                  <div className="col-sm-9">
                    <select className="form-control" valueLink={this.linkState('booked_by')}>
                      {member_options}
                    </select>
                  </div>
                </div>

                <hr />

                <div className="form-group">
                  <label className="col-sm-3 control-label">Miles <small><i>(total)</i></small></label>
                  <div className="col-sm-4">
                    <input type="number" className="form-control" valueLink={this.linkState('milage')} />
                  </div>
                  <label className="col-sm-2 control-label">Cars</label>
                  <div className="col-sm-3">
                    <input type="number" className="form-control" valueLink={this.linkState('vehicles')} />
                  </div>
                </div>
              </form>

              <div className="nnsb-modal__buttons">
                {delete_show}
                <button type="button" className="btn btn-primary" onClick={this._saveAndClose}>Save Changes</button>
              </div>
            </div>
          </div>
        </ReactCSSTransitionGroup>
      )
    else
      return (
        <ReactCSSTransitionGroup transitionName="nnsb-modal--animation" />
      )

#-----------  Export  -----------#

module.exports = ShowModal
