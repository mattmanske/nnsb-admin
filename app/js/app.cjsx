#-----------  Requirements  -----------#

$      = require('jquery')
moment = require('moment')
React  = require('react')

DateRangePicker = require('react-bootstrap-daterangepicker')

Store       = require('./stores/table_store')
DataTable   = require('./components/data_table')
MonthPicker = require('./components/month_picker')
ShowModal   = require('./components/show_modal')

#-----------  React Componet Class  -----------#

PageWrapper = React.createClass

  propTypes:
    shows       : React.PropTypes.array
    members     : React.PropTypes.array
    filterMonth : React.PropTypes.oneOfType([
      React.PropTypes.object,
      React.PropTypes.func
    ])

  getDefaultProps: ->
    Store.init()

    return {
      shows       : Store.getFilteredShows()
      members     : Store.getMembers()
      filterMonth : Store.getFilterMonth()
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

  componentDidMount: ->
    Store.addChangeListener(@_onFilterChange)
    $(window).on 'resize', @_onResize
    @_updateSizing()

  componentWillUnmount: ->
    Store.removeChangeListener(@_onFilterChange)

  #-----------  Event Handlers  -----------#

  _onResize: ->
    clearTimeout(@_updateTimer)
    @_updateTimer = setTimeout(@_updateSizing, 16)

  _onFilterChange: ->
    @setProps
      shows       : Store.getFilteredShows()
      members     : Store.getMembers()
      filterMonth : Store.getFilterMonth()

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
      isModalOpen : true

  _addNewShow: ->
    @setState
      currentShow : {}
      isModalOpen : true

  #-----------  HTML Element Render  -----------#

  render: ->
    return (
      <div className="page-wrapper">
        <MonthPicker filterMonth={this.state.filterMonth} />

        <DataTable
          shows={this.props.shows}
          members={this.props.members}
          tableWidth={this.state.tableWidth}
          tableHeight={this.state.tableHeight}
          filterMonth={this.props.filterMonth}
          editShow={this._editShow}
        />

        <ShowModal
          members={this.props.members}
          currentShow={this.state.currentShow}
          isModalOpen={this.state.isModalOpen}
          closeModal={this._closeModal}
        />

        <button className="btn btn-default" onClick={this._addNewShow}>Add New Show</button>
      </div>
    )

#-----------  Render  -----------#

React.render(<PageWrapper />, document.getElementById('content'))
