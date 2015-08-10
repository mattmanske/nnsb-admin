#-----------  Requirements  -----------#

React      = require('react')
moment     = require('moment')
classNames = require('classnames')

#-----------  React Componet Class  -----------#

DayPicker = React.createClass

  propTypes:
    value: React.PropTypes.oneOfType([
      React.PropTypes.object,
      React.PropTypes.func
    ])

  getDefaultProps: ->
    return {
      value: moment()
    }

  #-----------  HTML Element Render  -----------#

  render: ->
    date_dispaly = @props.value.format('DD/MM/YYYY')

    return (
      <div classNames="day-picker">{date_dispaly}</div>
    )

#-----------  Export  -----------#

module.exports = DayPicker
