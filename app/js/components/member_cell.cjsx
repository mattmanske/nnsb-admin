#-----------  Requirements  -----------#

React      = require('react')
classNames = require('classnames')

TableActions = require('./../actions/table_actions')

#-----------  React Componet Class  -----------#

MemberCell = React.createClass

  propTypes:
    showID       : React.PropTypes.number.isRequired
    memberID     : React.PropTypes.string.isRequired
    isParticpant : React.PropTypes.bool
    isBooker     : React.PropTypes.bool
    isPaid       : React.PropTypes.bool

  getDefaultProps: ->
    return {
      isParticpant : false
      isBooker     : false
      isPaid       : false
    }

  #-----------  Event Handlers  -----------#

  _toggleParticipant: ->
    TableActions.toggleParticipant(@props.memberID, @props.showID)

  #-----------  HTML Element Render  -----------#

  render: ->
    classes = classNames
      'member-cell'   : true
      'is-particpant' : @props.isParticpant
      'is-booker'     : @props.isBooker
      'is-paid'       : @props.isPaid

    return (
      <div classNames={classes}>
        <input
          type="checkbox"
          disabled={this.props.isPaid}
          defaultChecked={this.props.isParticpant}
          onChange={this._toggleParticipant}
          />
      </div>
    )
#-----------  Export  -----------#

module.exports = MemberCell
