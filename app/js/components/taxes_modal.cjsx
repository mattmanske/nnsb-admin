#-----------  Requirements  -----------#

$                       = require('jquery')
React                   = require('react/addons')
moment                  = require('moment')

TableActions            = require('./../actions/table_actions')
ReactCSSTransitionGroup = React.addons.CSSTransitionGroup

convertToCSV            = require('./../utils/utility_functions').convertToCSV
currencyFormater        = require('./../utils/utility_functions').currencyFormater

#-----------  React Componet Class  -----------#

TaxesModal = React.createClass

  mixins: [React.addons.LinkedStateMixin]

  propTypes:
    year        : React.PropTypes.number
    shows       : React.PropTypes.array
    isModalOpen : React.PropTypes.bool
    closeModal  : React.PropTypes.func.isRequired

  getDefaultProps: ->
    return {
      year        : moment().year()
      isModalOpen : false
    }

  #-----------  Event Handlers  -----------#

  _closeModal: (evt) ->
    if $(evt.target).hasClass('nnsb-modal') || $(evt.target).hasClass('nnsb-modal__close')
      @props.closeModal()

  _doanloadCSV: (evt) ->
    data = []
    data.push(['Date', 'Location', 'Payment'])
    for show in @props.shows
      data.push([show.date, show.name, show.payment])

    file_name = 'nnsb_' + @props.year + '_taxes.csv'
    file_data = 'data:Application/octet-stream,' + encodeURIComponent(convertToCSV(data))
    $("<a href='#{file_data}' download='#{file_name}' style='display:none'></a>").appendTo('body')[0].click()

  #-----------  HTML Element Render  -----------#

  render: ->
    if @props.isModalOpen
      taxes = []
      total_taxed = 0
      total_payment = 0

      for show in @props.shows
        key = show.date + '_' + show.name
        payment = parseInt(show.payment)
        total_taxed = total_taxed + payment if show.is_taxed
        total_payment = total_payment + payment

        taxes.push (
          <tr key={key}>
            <td>{moment(show.date).format('M/D/YY')}</td>
            <td>{show.name}</td>
            <td>{currencyFormater(show.payment)}</td>
          </tr>
        )

      return (
        <ReactCSSTransitionGroup transitionName="nnsb-modal--animation">
          <div className="nnsb-modal" onClick={this._closeModal}>
            <div className="nnsb-modal__block">
              <a className="nnsb-modal__close" onClick={this._closeModal}>&times;</a>

              <button className="btn btn-default btn-sm pull-right" onClick={this._doanloadCSV}>Download CSV</button>
              <h5>{this.props.year} Taxed Shows</h5>

              <table className="table table-condensed table-hover">
                <thead>
                  <tr>
                    <th>Date</th>
                    <th>Show</th>
                    <th>Payment</th>
                  </tr>
                </thead>
                <tbody>
                  {taxes}
                </tbody>
                <tfoot>
                  <tr>
                    <th>
                      <small className="text-muted"><i>{this.props.year} shows ({this.props.shows.length}):</i></small>
                    </th>
                    <th colSpan='2'>
                      <i>(W9: {currencyFormater(total_taxed)})</i>
                      {currencyFormater(total_payment)}
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

module.exports = TaxesModal
