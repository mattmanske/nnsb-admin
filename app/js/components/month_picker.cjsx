#-----------  Requirements  -----------#

React        = require('react')
moment       = require('moment')
classNames   = require('classnames')
TableActions = require('./../actions/table_actions')

PropTypes = React.PropTypes

#-----------  React Componet Class  -----------#

MonthPicker = React.createClass

  propTypes:
    filterMonth: PropTypes.oneOfType([PropTypes.object, PropTypes.func])

  getDefaultProps: ->
    return {
      filterMonth: moment()
    }

  #-----------  Event Handlers  -----------#

  _prevMonth: (evt) ->
    TableActions.changeFilters(@props.filterMonth.subtract(1, 'month').startOf('month'))

  _nextMonth: (evt) ->
    TableActions.changeFilters(@props.filterMonth.add(1, 'month').startOf('month')) unless @_isThisMonth()

  #-----------  HTML Element Render  -----------#

  _isThisMonth: ->
    return (moment() < @props.filterMonth.endOf('month'))

  render: ->
    btn_classes = classNames
      'btn'         : true
      'btn-xs'      : true
      'btn-default' : true

    next_classes = classNames btn_classes,
      'disabled' : @_isThisMonth()

    month_display = @props.filterMonth.format('MMMM YYYY')

    return (
      <div className="btn-group">
        <button type="button" className={btn_classes} onClick={this._prevMonth}>
          <i className="glyphicon glyphicon-chevron-left"></i>
        </button>

        <span>{month_display}</span>

        <button type="button" className={next_classes} onClick={this._nextMonth}>
          <i className="glyphicon glyphicon-chevron-right"></i>
        </button>
      </div>
    )

#-----------  Export  -----------#

module.exports = MonthPicker
