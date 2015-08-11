#-----------  Module  -----------#

UtilityFunctions =

  # ---------------
  # Formats a numer into a USD-style currency string
  #
  # @param: {Int/Fixed} number - number to format
  # ---------------

  currencyFormater: (number) ->
    return '–' unless number

    value = parseFloat(number)

    unless value % 1 == 0
      value = value.toFixed(2)

    return '$' + value

#-----------  Export  -----------#

module.exports = UtilityFunctions
