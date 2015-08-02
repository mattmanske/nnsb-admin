#-----------  Requirements  -----------#

# for documentation on the Fixed Data Table components
# see https://facebook.github.io/fixed-data-table/

React          = require('react')
FixedDataTable = require('fixed-data-table')

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

  #-----------  HTML Element Render  -----------#

  render: ->
    memberColumns = []
    console.log @props

    for member, index in @props.members
      memberColumns.push(
        <Column
          width={100}
          key={member.id}
          dataKey={member.id}
          columnData={member}
          label={member.name}
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
        overflowX="auto"
        overflowY="auto"
      >
        <ColumnGroup fixed={true} label="Shows">
          <Column
            width={133}
            fixed={true}
            key="name"
            label="Show"
            dataKey="name"
            flexGrow={1}
          />
          <Column
            width={85}
            fixed={true}
            key="payment"
            label="Payment"
            dataKey="payment"
          />
          <Column
            width={85}
            fixed={true}
            key="booked_by"
            label="Booked By"
            dataKey="booked_by"
          />
        </ColumnGroup>
        <ColumnGroup fixed={true} label="Members">
          {memberColumns}
        </ColumnGroup>
      </Table>
    )

  # #-----------  Member Components  -----------#

  # _getMemberCell: (cellData, cellDataKey, rowData, rowInded, columnData, width) ->
  #   return (<div>{rowInded}</div>)

  # _getMemberHeader: (label, cellDataKey, columnData, rowData, width) ->
  #   return (<div>{columnData.name}</div>)

  # _getMemberFooter: (label, cellDataKey, columnData, rowData, width) ->
  #   return (<div>{columnData.name}</div>)

  # #-----------  Show Components  -----------#

  # _getShowCell: (cellData, cellDataKey, rowData, rowInded, columnData, width) ->
  #   return (<div>{rowInded}</div>)

  # _getShowHeader: (label, cellDataKey, columnData, rowData, width) ->
  #   return (<div>{columnData.name}</div>)

  # _getShowFooter: (label, cellDataKey, columnData, rowData, width) ->
  #   return (<div>{columnData.name}</div>)

#-----------  Export  -----------#

module.exports = DataTable
