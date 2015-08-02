#-----------  Requirements  -----------#

$      = require('jquery')
React  = require('react')
moment = require('moment')

Store           = require('./stores/table_store')
DataTable       = require('./components/data_table')
MonthPicker     = require('./components/month_picker')
DateRangePicker = require('react-bootstrap-daterangepicker')

#-----------  React Componet Class  -----------#

PageWrapper = React.createClass

  getInitialState: ->
    return {
      filterMonth : Store.getFilterMonth()
      members     : Store.getMembers()
      shows       : Store.getFilteredShows()
      tableHeight : 300
      tableWidth  : 1000
    }

  #-----------  Event Handlers  -----------#

  componentDidMount: ->
    Store.addChangeListener(@_onFilterChange)

  componentWillUnmount: ->
    Store.removeChangeListener(@_onFilterChange)

  _onFilterChange: ->
    @setState
      filterMonth : Store.getFilterMonth()
      members     : Store.getMembers()
      shows       : Store.getFilteredShows()

  #-----------  HTML Element Render  -----------#

  render: ->
    return (
      <div className="page-wrapper">
        <MonthPicker filterMonth={this.state.filterMonth} />

        <DataTable
          shows={this.state.shows}
          members={this.state.members}
          tableWidth={this.state.tableWidth}
          tableHeight={this.state.tableHeight}
        />
      </div>
    )

#-----------  Render  -----------#

React.render(<PageWrapper />, document.getElementById('content'))
