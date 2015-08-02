#-----------  Requirements  -----------#

# for documentation on the Fixed Data Table components
# see https://facebook.github.io/fixed-data-table/

_              = require('underscore')
React          = require('react')
FixedDataTable = require('fixed-data-table')

Store            = require('./../stores/table_store')
currencyFormater = require('./../utils/utility_functions').currencyFormater

Table       = FixedDataTable.Table
Column      = FixedDataTable.Column
ColumnGroup = FixedDataTable.ColumnGroup

#-----------  React Componet Class  -----------#

DataTable = React.createClass

  getInitialState: ->
    return {}

  #-----------  Table Data Grabs  -----------#

  _rowGetter: (index) ->
    return @props.shows[index]

  _footerDataGetter: ->
    return [@props.filterMonth]

  #-----------  HTML Element Render  -----------#

  render: ->
    memberColumns = []

    for member, index in @props.members
      member.show_total = Store.getMemberShowsTotal(member.id)
      member.payment_total = Store.getMemberPaymentTotal(member.id)

      memberColumns.push(
        <Column
          width={100}
          key={member.id}
          dataKey={member.id}
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
        groupHeaderHeight={30}
        width={this.props.tableWidth}
        height={this.props.tableHeight}
        rowGetter={this._rowGetter}
        rowsCount={this.props.shows.length}
        footerDataGetter={this._footerDataGetter}
        overflowX="auto"
        overflowY="auto"
      >
        <ColumnGroup fixed={true} label="Shows">
          <Column
            width={67}
            fixed={true}
            key="date"
            label="Date"
            dataKey="date"
            cellRenderer={this._getShowDateCell}
            footerRenderer={this._getShowDateFooter}
          />
          <Column
            width={100}
            fixed={true}
            key="name"
            label="Show"
            dataKey="name"
            flexGrow={1}
            footerRenderer={this._getShowNameFooter}
          />
          <Column
            width={85}
            fixed={true}
            key="payment"
            label="Payment"
            dataKey="payment"
            cellRenderer={this._getShowPaymentCell}
            footerRenderer={this._getShowPaymentFooter}
          />
          <Column
            width={100}
            fixed={true}
            key="booked_by"
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

  #-----------  Member Components  -----------#

  _getMemberCell: (cellData, cellDataKey, rowData, rowInded, columnData, width) ->
    is_participant = _.contains(rowData.participants, cellDataKey)
    return (
      <div>
        <input type="checkbox" checked={is_participant} />
      </div>
    )

  _getMemberFooter: (label, cellDataKey, columnData, rowData, width) ->
    return (
      <div>
        <small>{columnData.name}: ({columnData.show_total})</small>
        <br />{currencyFormater(columnData.payment_total)}
      </div>
    )

  #-----------  Show Components  -----------#

  _getShowDateCell: (cellData, cellDataKey, rowData, rowInded, columnData, width) ->
    return (<div>{cellData.format('M/D/YY')}</div>)

  _getShowPaymentCell: (cellData, cellDataKey, rowData, rowInded, columnData, width) ->
    return (<div>{currencyFormater(cellData)}</div>)

  _getShowBookedCell: (cellData, cellDataKey, rowData, rowInded, columnData, width) ->
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
