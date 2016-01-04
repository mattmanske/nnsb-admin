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

  # ---------------
  # Turns JS array into CSV string for download
  #
  # @param: {Arr} data - data array to format
  # ---------------

  convertToCSV: (data) ->
    csv = ''

    for row in data
      for cell in row
        csv += cell + ','
      csv += '\n'

    return csv

#-----------  Export  -----------#

module.exports = UtilityFunctions
