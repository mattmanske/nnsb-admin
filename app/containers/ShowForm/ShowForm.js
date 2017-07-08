//-----------  Imports  -----------//

import Show                 from './styles'

import React, { PropTypes } from 'react'
import { Field, reduxForm } from 'redux-form'
import { Input,
         Select,
         Switch,
         Checkbox,
         DatePicker,
         Popconfirm,
         InputNumber }      from 'antd'

import ReduxAntdSubmit      from 'components/ReduxAntdSubmit'
import ReduxAntdWrapper     from 'components/ReduxAntdWrapper'

import { isMoment,
         isNumber,
         isRequired }       from 'utils/forms'

import { memberOptions }    from 'utils/members'

//-----------  Definitions  -----------//

const Option = Select.Option

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
  const { data, error, isLoading, isWatching } = props.members
  const membersReady = (isWatching && !isLoading)

  const Delete = props.initialValues && !!props.initialValues.key && (
    <Popconfirm
      placement='right'
      title='Are you sure you want to delete this show?'
      onConfirm={() => props.deleteShow(props.initialValues.key)}
    >
      <Show.Delete>delete</Show.Delete>
    </Popconfirm>
  )

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
        loading={!membersReady}
        component={ReduxAntdWrapper}
      >
        <Select>
          <Option value='0'>-none-</Option>
          {data.map(member => (
            <Option key={member.key} value={member.key}>{member.name}</Option>
          ))}
        </Select>
      </Field>

      <Show.Line />

      <Field
        name='participants'
        label='Players'
        required={true}
        layout='horizontal'
        loading={!membersReady}
        component={ReduxAntdWrapper}
      >
        <Checkbox.Group options={memberOptions(data)} />
      </Field>

      <ReduxAntdSubmit text='Submit' other={Delete} {...props} />
    </Show.Wrapper>
  )
}

//-----------  Prop Types  -----------//

ShowForm.propTypes = {
  members         : PropTypes.object.isRequired,
  deleteShow      : PropTypes.func.isRequired,
  onSubmit        : PropTypes.func.isRequired,
  onSubmitSuccess : PropTypes.func.isRequired,
}

//-----------  Export  -----------//

export default reduxForm({ form: 'show', validate })(ShowForm)
