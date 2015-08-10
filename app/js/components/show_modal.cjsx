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
    members     : React.PropTypes.array
    currentShow : React.PropTypes.object
    isModalOpen : React.PropTypes.bool
    closeModal  : React.PropTypes.func.isRequired

  getDefaultProps: ->
    return {
      members     : []
      currentShow : {}
      isModalOpen : false
    }

  componentWillReceiveProps: (new_props) ->
    show = new_props.currentShow
    formatted_date = if show.date then show.date.format('YYYY-MM-DD') else moment().format('YYYY-MM-DD')
    @setState {
      name      : show.name
      date      : formatted_date
      payment   : show.payment
      booked_by : show.booked_by
    }

  #-----------  Event Handlers  -----------#

  _saveAndClose: ->
    console.log @state
    # TableActions.addNewShow()

  #-----------  HTML Element Render  -----------#

  render: ->
    member_options = [<option key="0" value="0">– none –</option>]

    for index, member of @props.members
      member_options.push <option key={member.id} value={member.id}>{member.name}</option>

    if @props.isModalOpen
      return (
        <ReactCSSTransitionGroup transitionName="nnsb-modal--animation">
          <div className="nnsb-modal">
            <div className="nnsb-modal__block">
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
                  <div className="col-sm-9">
                    <input type="number" className="form-control" valueLink={this.linkState('payment')} />
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
              </form>

              <button type="button" className="btn btn-default" onClick={this.props.closeModal}>Close</button>
              <button type="button" className="btn btn-primary" onClick={this._saveAndClose}>Save Changes</button>
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
