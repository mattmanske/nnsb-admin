#-----------  Requirements  -----------#

$               = require('jquery')
moment          = require('moment')
React           = require('react')

DateRangePicker = require('react-bootstrap-daterangepicker')

Store           = require('./stores/table_store')
DataTable       = require('./components/data_table')
MonthPicker     = require('./components/month_picker')
ShowModal       = require('./components/show_modal')
TaxesModal      = require('./components/taxes_modal')
DeductionsModal = require('./components/deductions_modal')

#-----------  React Componet Class  -----------#

PageWrapper = React.createClass

  propTypes:
    shows      : React.PropTypes.array
    month      : React.PropTypes.oneOfType([
      React.PropTypes.object,
      React.PropTypes.func
    ])
    taxes      : React.PropTypes.array
    members    : React.PropTypes.object
    deductions : React.PropTypes.array

  getDefaultProps: ->
    return {
      shows      : Store.getVisibleShows()
      month      : Store.getFilterMonth()
      members    : Store.getMembers()
      taxes      : Store.getVisibleTaxes()
      deductions : Store.getVisibleDeductions()
    }

  getInitialState: ->
    return {
      currentShow : {}
      isModalOpen : false
      tableHeight : 500
      tableWidth  : 1250
      renderPage  : false
    }

  #-----------  Mount / Unmount  -----------#

  componentWillMount: ->
    Store.init()

  componentDidMount: ->
    Store.addChangeListener(@_onDataChange)
    $(window).on('resize', @_onResize)
    @_updateSizing()

  componentWillUnmount: ->
    Store.removeChangeListener(@_onDataChange)

  #-----------  Event Handlers  -----------#

  _onResize: ->
    clearTimeout(@_updateTimer)
    @_updateTimer = setTimeout(@_updateSizing, 16)

  _onDataChange: ->
    @setProps
      shows      : Store.getVisibleShows()
      month      : Store.getFilterMonth()
      members    : Store.getMembers()
      taxes      : Store.getVisibleTaxes()
      deductions : Store.getVisibleDeductions()

  _updateSizing: ->
    @setState
      tableWidth  : $('#content').width()
      renderPage  : true

  _closeModal: ->
    @setState
      currentShow : {}
      isModalOpen : false

  _editShow: (show) ->
    @setState
      currentShow : show
      isModalOpen : 'shows'

  _addNewShow: ->
    @setState
      currentShow : {}
      isModalOpen : 'shows'

  _showYearlyTaxes: ->
    @setState
      isModalOpen : 'taxes'

  _showYearlyDeductions: ->
    @setState
      isModalOpen : 'deductions'

  #-----------  HTML Element Render  -----------#

  render: ->
    currentYear = if @props.month then @props.month.year() else moment().year()

    showShowModal       = @state.isModalOpen == 'shows'
    showTaxesModal      = @state.isModalOpen == 'taxes'
    showDeductionsModal = @state.isModalOpen == 'deductions'

    return (
      <div className="page-wrapper">
        <MonthPicker filterMonth={this.props.month} />

        <DataTable
          year={currentYear}
          shows={this.props.shows}
          members={this.props.members}
          tableWidth={this.state.tableWidth}
          tableHeight={this.state.tableHeight}
          filterMonth={this.props.month}
          editShow={this._editShow}
        />

        <ShowModal
          members={this.props.members}
          currentShow={this.state.currentShow}
          isModalOpen={showShowModal}
          closeModal={this._closeModal}
        />

        <TaxesModal
          year={currentYear}
          shows={this.props.taxes}
          isModalOpen={showTaxesModal}
          closeModal={this._closeModal}
        />

        <DeductionsModal
          year={currentYear}
          shows={this.props.deductions}
          isModalOpen={showDeductionsModal}
          closeModal={this._closeModal}
        />

        <button className="btn btn-default" onClick={this._addNewShow}>Add New Show</button>
        <button className="btn btn-default pull-right" onClick={this._showYearlyTaxes}>{currentYear} Taxes</button>
        <button className="btn btn-default pull-right" onClick={this._showYearlyDeductions}>{currentYear} Deductions</button>
      </div>
    )

#-----------  Render  -----------#

React.render(<PageWrapper />, document.getElementById('content'))
