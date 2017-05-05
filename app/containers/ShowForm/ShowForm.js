//-----------  Imports  -----------//

import Show                 from './styles'

import React, { PropTypes } from 'react'
import { Field, reduxForm } from 'redux-form'
import { Input,
         Select,
         Switch,
         Checkbox,
         DatePicker,
         InputNumber }      from 'antd'

import ReduxAntdSubmit      from 'components/ReduxAntdSubmit'
import ReduxAntdWrapper     from 'components/ReduxAntdWrapper'

import { isMoment,
         isNumber,
         isRequired }       from 'utils/forms'

import { MEMBERS,
         memberOptions }    from 'utils/shows'

//-----------  Validation  -----------//

function validate(values){
  const errors = {}

  if (!isMoment(values.date))
    errors.date = 'Invalid date'

  if (!isRequired(values.name))
    errors.name = 'Required'

  if (!isNumber(values.payment))
    errors.payment = 'Required'

  return errors
}

//-----------  Component  -----------//

const ShowForm = (props) => {

  return (
    <Show.Wrapper noValidate onSubmit={props.handleSubmit}>
      <Field
        name='date'
        label='Date'
        required={true}
        layout='horizontal'
        component={ReduxAntdWrapper}
      >
        <DatePicker placeholder='' format={'MMMM Do, YYYY'} />
      </Field>

      <Field
        name='name'
        label='Name'
        required={true}
        layout='horizontal'
        component={ReduxAntdWrapper}
      >
        <Input />
      </Field>

      <Show.SideBySide>
        <Field
          name='payment'
          label='Payment'
          required={true}
          layout='horizontal'
          component={ReduxAntdWrapper}
        >
          <InputNumber
            min={0}
            parser={val => val.replace(/\$\s?|(,*)/g, '')}
            formatter={val => `$ ${val.replace(/\B(?=(\d{3})+(?!\d))/g, ',')}`}
          />
        </Field>

        <Field
          name='is_taxed'
          label='W-9'
          required={true}
          component={ReduxAntdWrapper}
        >
          <Switch size='small' />
        </Field>
      </Show.SideBySide>

      <Field
        name='booked_by'
        label='Booker'
        required={true}
        layout='horizontal'
        component={ReduxAntdWrapper}
      >
        <Select>
          <Select.Option value='0'>-none-</Select.Option>
          {MEMBERS.map(member => (
            <Select.Option key={member.id} value={member.id}>{member.name}</Select.Option>
          ))}
        </Select>
      </Field>

      <Show.Line />

      <Field
        name='participants'
        label='Players'
        required={true}
        layout='horizontal'
        component={ReduxAntdWrapper}
      >
        <Checkbox.Group options={memberOptions()} />
      </Field>

      <ReduxAntdSubmit text='Submit' {...props} />
    </Show.Wrapper>
  )
}

//-----------  Prop Types  -----------//

ShowForm.propTypes = {
  onSubmit: PropTypes.func.isRequired
}

//-----------  Export  -----------//

export default reduxForm({ form: 'show', validate })(ShowForm)