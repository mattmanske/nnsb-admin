#-----------  Requirements  -----------#

# for documentation on the Fixed Data Table components
# see https://facebook.github.io/fixed-data-table/

_          = require('underscore')
classNames = require('classnames')

React          = require('react')
FixedDataTable = require('fixed-data-table')

Store            = require('./../stores/table_store')
TableActions     = require('./../actions/table_actions')
currencyFormater = require('./../utils/utility_functions').currencyFormater

Table       = FixedDataTable.Table
Column      = FixedDataTable.Column
ColumnGroup = FixedDataTable.ColumnGroup

#-----------  React Componet Class  -----------#

DataTable = React.createClass

  propTypes:
    shows       : React.PropTypes.array
    members     : React.PropTypes.object
    tableWidth  : React.PropTypes.number
    tableHeight : React.PropTypes.number
    filterMonth : React.PropTypes.oneOfType([
      React.PropTypes.object,
      React.PropTypes.func
    ])

  #-----------  Table Data Grabs  -----------#

  _rowGetter: (index) ->
    return @props.shows[index]

  _footerDataGetter: ->
    return [@props.filterMonth]

  _rowClassNameGetter: (index) ->
    return if @props.shows[index].is_paid then 'paid-row' else 'unpaid-row'

  #-----------  HTML Element Render  -----------#

  render: ->
    memberColumns = []

    for member_id, member of @props.members
      member.show_total = Store.getMemberShowsTotal(member_id)
      member.payment_total = Store.getMemberPaymentTotal(member_id)

      memberColumns.push(
        <Column
          width={100}
          key={member_id}
          align="center"
          dataKey={member_id}
          columnData={member}
          label={member.name}
          cellRenderer={this._getMemberCell}
          footerRenderer={this._getMemberFooter}
        />
      )

    return (
      <Table
        rowHeight={50}
        headerHeight={50}
        footerHeight={65}
        groupHeaderHeight={40}
        width={this.props.tableWidth}
        height={this.props.tableHeight}
        rowGetter={this._rowGetter}
        rowsCount={this.props.shows.length}
        footerDataGetter={this._footerDataGetter}
        rowClassNameGetter={this._rowClassNameGetter}
        overflowX="auto"
        overflowY="auto"
      >
        <ColumnGroup fixed={true} label="Shows">
          <Column
            width={45}
            fixed={true}
            key="is_paid"
            align="center"
            dataKey="is_paid"
            cellRenderer={this._getShowPaidCell}
            headerRenderer={this._getShowPaidHeader}
          />
          <Column
            width={67}
            fixed={true}
            key="date"
            label="Date"
            align="center"
            dataKey="date"
            cellRenderer={this._getShowDateCell}
            footerRenderer={this._getShowDateFooter}
          />
          <Column
            width={100}
            fixed={true}
            key="name"
            label="Show"
            align="center"
            dataKey="name"
            flexGrow={1}
            footerRenderer={this._getShowNameFooter}
          />
          <Column
            width={85}
            fixed={true}
            key="payment"
            align="center"
            label="Payment"
            dataKey="payment"
            cellRenderer={this._getShowPaymentCell}
            footerRenderer={this._getShowPaymentFooter}
          />
          <Column
            width={100}
            fixed={true}
            key="booked_by"
            align="center"
            label="Booked"
            dataKey="booked_by"
            cellRenderer={this._getShowBookedCell}
            footerRenderer={this._getShowBookedFooter}
          />
        </ColumnGroup>
        <ColumnGroup fixed={true} label="Members">
          {memberColumns}
        </ColumnGroup>
      </Table>
    )

  #-----------  Event Handlers  -----------#

  _toggleIsPaid: (evt) ->
    TableActions.toggleIsPaid(evt.target.value)

  _toggleAllIsPaid: ->
    TableActions.toggleAllIsPaid()

  #-----------  Member Components  -----------#

  _getMemberCell: (cellData, cellDataKey, rowData, rowIndex, columnData, width) ->
    is_participant = _.contains(rowData.participants, cellDataKey)
    return (<div><input type="checkbox" checked={is_participant} readOnly={true} /></div>)

  _getMemberFooter: (label, cellDataKey, columnData, rowData, width) ->
    return (
      <div>
        <small>{columnData.name}: ({columnData.show_total})</small>
        <br />{currencyFormater(columnData.payment_total)}
      </div>
    )

  #-----------  Show Components  -----------#

  _getShowPaidCell: (cellData, cellDataKey, rowData, rowIndex, columnData, width) ->
    return (<div><input type="checkbox" defaultChecked={rowData.is_paid} disabled={rowData.is_paid} value={rowData.id} onChange={this._toggleIsPaid} /></div>)

  _getShowPaidHeader: (label, cellDataKey, columnData, rowData, width) ->
    is_paid = (Store.getNumberPaid() == @props.shows.length)
    return (<div><input type="checkbox" defaultChecked={is_paid} disabled={is_paid} onChange={this._toggleAllIsPaid} /></div>)

  _getShowDateCell: (cellData, cellDataKey, rowData, rowIndex, columnData, width) ->
    return (<div>{cellData.format('M/D/YY')}</div>)

  _getShowPaymentCell: (cellData, cellDataKey, rowData, rowIndex, columnData, width) ->
    return (<div>{currencyFormater(cellData)}</div>)

  _getShowBookedCell: (cellData, cellDataKey, rowData, rowIndex, columnData, width) ->
    return (<div>{Store.getMemberName(cellData)}</div>)

  _getShowDateFooter: (label, cellDataKey, columnData, rowData, width) ->
    return (<div>Totals:</div>)

  _getShowNameFooter: (label, cellDataKey, columnData, rowData, width) ->
    return (<div>{this.props.shows.length} shows</div>)

  _getShowPaymentFooter: (label, cellDataKey, columnData, rowData, width) ->
    return (<div>{currencyFormater(Store.getShowsTotalCollected())}</div>)

  _getShowBookedFooter: (label, cellDataKey, columnData, rowData, width) ->
    return (
      <div>
        <small>NNSB: ({Store.getMemberShowsTotal()})</small>
        <br />{currencyFormater(Store.getMemberPaymentTotal())}
      </div>
    )

#-----------  Export  -----------#

module.exports = DataTable
