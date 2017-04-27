//-----------  Imports  -----------//

import _        from 'lodash'
import moment   from 'moment'
import validaor from 'validator'

//-----------  Masks  -----------//

let maskPhone = ['(', /[1-9]/, /\d/, /\d/, ')', ' ', /\d/, /\d/, /\d/, '-', /\d/, /\d/, /\d/, /\d/]

// let maskSubdomain = ['h', 't', 't', 'p', ':', '/', '/', /[a-zA-Z]/, '.', 'u', 's']

const pipeSubdomain = (confirmedValue, config) => {
  return confirmedValue.toLowerCase()
}

//-----------  Validators  -----------//

const isRequired = (val) => val && val.length

const isEmail = (val) => val && validaor.isEmail(val)

const isPhone = (val) => val && (val.replace(/[^\d]/g, '').length == 10)

const isPassword = (val) => val && val.match(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/)

const passwordsMatch = ({ user }) => user.password == user.password_confirmation

const isSubdomain = (val) => val && val.match(/[A-Za-z0-9](?:[A-Za-z0-9\-]{0,61}[A-Za-z0-9])?/)

const isMoment = (val) => val && moment(val).isValid()

//-----------  Exports  -----------//

export {
  maskPhone,
  pipeSubdomain,
  isRequired,
  isEmail,
  isPassword,
  passwordsMatch,
  isSubdomain,
  isPhone,
  isMoment
}
