#-----------  Requirements  -----------#

React        = require('react/addons')
moment       = require('moment')
classNames   = require('classnames')

TableActions     = require('./../actions/table_actions')
currencyFormater = require('./../utils/utility_functions').currencyFormater

ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

#-----------  React Componet Class  -----------#

DeductionsModal = React.createClass

  mixins: [React.addons.LinkedStateMixin]

  propTypes:
    year        : React.PropTypes.number
    shows       : React.PropTypes.array
    isModalOpen : React.PropTypes.bool
    closeModal  : React.PropTypes.func.isRequired

  getDefaultProps: ->
    return {
      year        : moment().year()
      deductions  : []
      isModalOpen : false
    }

  #-----------  Event Handlers  -----------#

  _closeModal: (evt) ->
    if $(evt.target).hasClass('nnsb-modal') || $(evt.target).hasClass('nnsb-modal__close')
      @props.closeModal()

  #-----------  HTML Element Render  -----------#

  render: ->
    if @props.isModalOpen
      deductions = []
      total_deductions = 0
      tax_rate = switch
        when @props.year == 2015 then 0.575
        when @props.year == 2016 then 0.54
        else 0.56

      for show in @props.shows
        key = show.date + '_' + show.name
        deduction = (show.milage * show.vehicles * tax_rate)
        total_deductions = total_deductions + deduction

        deductions.push (
          <tr key={key}>
            <td>{moment(show.date).format('M/D/YY')}</td>
            <td>{show.name}</td>
            <td>{show.milage}</td>
            <td>{show.vehicles}</td>
            <td>{currencyFormater(deduction)}</td>
          </tr>
        )

      return (
        <ReactCSSTransitionGroup transitionName="nnsb-modal--animation">
          <div className="nnsb-modal" onClick={this._closeModal}>
            <div className="nnsb-modal__block">
              <a className="nnsb-modal__close" onClick={this._closeModal}>&times;</a>

              <button className="btn btn-default btm-xs pull-right">Download XLS</button>
              <h5>{this.props.year} Deductions <i className="text-muted">(at ${tax_rate}/mi)</i></h5>

              <table className="table table-condensed table-hover">
                <thead>
                  <tr>
                    <th>Date</th>
                    <th>Show</th>
                    <th>Miles</th>
                    <th>Cars</th>
                    <th>Deduction</th>
                  </tr>
                </thead>
                <tbody>
                  {deductions}
                </tbody>
                <tfoot>
                  <tr>
                    <th colSpan="5">
                      <small className="text-muted"><i>{this.props.year} total:</i></small>&nbsp;&nbsp;
                      {currencyFormater(total_deductions)}
                    </th>
                  </tr>
                </tfoot>
              </table>
            </div>
          </div>
        </ReactCSSTransitionGroup>
      )
    else
      return (
        <ReactCSSTransitionGroup transitionName="nnsb-modal--animation" />
      )

#-----------  Export  -----------#

module.exports = DeductionsModal
