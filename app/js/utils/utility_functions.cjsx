#-----------  Module  -----------#

UtilityFunctions =

  # ---------------
  # Formats a numer into a USD-style currency string
  #
  # @param: {Int/Fixed} number - number to format
  # ---------------

   currencyFormater: (number) ->
     decimalplaces     = 0
     decimalcharacter  = ''
     thousandseparater = ','
     currencyCharacter = '$'

     number    = parseFloat(number)
     sign      = if number < 0 then '-' else ''
     formatted = new String(number.toFixed(decimalplaces))

     if decimalcharacter.length and decimalcharacter != '.'
       formatted = formatted.replace(/\./, decimalcharacter)

     integer   = ''
     fraction  = ''
     strnumber = new String(formatted)
     dotpos    = if decimalcharacter.length then strnumber.indexOf(decimalcharacter) else -1

     if dotpos > -1
       if dotpos
         integer = strnumber.substr(0, dotpos)
       fraction = strnumber.substr(dotpos + 1)
     else
       integer = strnumber
     if integer
       integer = String(Math.abs(integer))

     while fraction.length < decimalplaces
       fraction += '0'

     temparray = new Array

     while integer.length > 3
       temparray.unshift integer.substr(-3)
       integer = integer.substr(0, integer.length - 3)

     temparray.unshift integer
     integer = temparray.join(thousandseparater)
     return sign + currencyCharacter + integer + decimalcharacter + fraction

#-----------  Export  -----------#

module.exports = UtilityFunctions
