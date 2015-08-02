#-----------  Requirements  -----------#

# for documentation on the Fixed Data Table components
# see https://facebook.github.io/fixed-data-table/

React          = require('react')
FixedDataTable = require('fixed-data-table')

Table  = FixedDataTable.Table
Column = FixedDataTable.Column

#-----------  React Componet Class  -----------#

DataTable = React.createClass

  getInitialState: ->
    return {}

  #-----------  Table Data Grabs  -----------#

  _rowGetter: (index) ->
    return @props.shows[index]

  _headerDataGetter: () ->
    return [true]

  _footerDataGetter: () ->
    return [true]

  #-----------  HTML Element Render  -----------#

  render: ->
    memberColumns = []

    for member, index in @props.members
      memberColumns.push(
        <Column
          width={100}
          key={member.id}
          dataKey={member.id}
          columnData={member}
          cellRenderer={this._getMemberCell}
          headerRenderer={this._getMemberHeader}
          footerRenderer={this._getMemberFooter}
        />
      )

    return (
      <Table
        rowHeight={50}
        headerHeight={50}
        footerHeight={50}
        width={this.props.tableWidth}
        height={this.props.tableHeight}
        rowGetter={this._rowGetter}
        rowsCount={this.props.shows.length}
        headerDataGetter={this._headerDataGetter}
        footerDataGetter={this._footerDataGetter}
        overflowX="auto"
        overflowY="auto"
      >

        <Column
          width={100}
          fixed={true}
          key="show"
          dataKey="show"
          cellRenderer={this._getShowCell}
          headerRenderer={this._getShowHeader}
          footerRenderer={this._getShowFooter}
        />

        {memberColumns}

      </Table>
    )

  #-----------  Member Components  -----------#

  _getMemberCell: (cellData, cellDataKey, rowData, rowInded, columnData, width) ->
    return (<div>{rowInded}</div>)

  _getMemberHeader: (label, cellDataKey, columnData, rowData, width) ->
    return (<div>{columnData.name}</div>)

  _getMemberFooter: (label, cellDataKey, columnData, rowData, width) ->
    return (<div>{columnData.name}</div>)

  #-----------  Show Components  -----------#

  _getShowCell: (cellData, cellDataKey, rowData, rowInded, columnData, width) ->
    return (<div>{rowInded}</div>)

  _getShowHeader: (label, cellDataKey, columnData, rowData, width) ->
    return (<div>{columnData.name}</div>)

  _getShowFooter: (label, cellDataKey, columnData, rowData, width) ->
    return (<div>{columnData.name}</div>)

#-----------  Export  -----------#

module.exports = DataTable
