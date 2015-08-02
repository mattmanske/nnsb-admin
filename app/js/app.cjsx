#-----------  Requirements  -----------#

$      = require('jquery')
React  = require('react')
moment = require('moment')

DateRangePicker = require('react-bootstrap-daterangepicker')

Store       = require('./stores/table_store')
DataTable   = require('./components/data_table')
MonthPicker = require('./components/month_picker')
ShowModal   = require('./components/show_modal')

#-----------  React Componet Class  -----------#

PageWrapper = React.createClass

  getInitialState: ->
    Store.init()

    return {
      filterMonth : Store.getFilterMonth()
      members     : Store.getMembers()
      shows       : Store.getFilteredShows()
      tableHeight : 500
      tableWidth  : 1250
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
          filterMonth={this.state.filterMonth}
        />

        <ShowModal />
      </div>
    )

#-----------  Render  -----------#

React.render(<PageWrapper />, document.getElementById('content'))
