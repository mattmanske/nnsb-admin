//-----------  Imports  -----------//

import Customers            from './styles'

import moment               from 'moment'
import reduce               from 'lodash/reduce'
import orderBy              from 'lodash/orderBy'

import React, { PropTypes } from 'react'
import { Icon, Button }     from 'antd'

import Money                from 'components/Money'

//-----------  Component  -----------//

const CustomersTable = (props) => {
  const { data, error, isLoading, isWatching } = props.customers
  const pageReady = (isWatching && !isLoading)

  const customers = orderBy(data, [c => c.created_at ? moment(c.created_at).valueOf() : 0, 'email'], ['desc', 'asc'])

  return (
    <Customers.List
      size='small'
      rowKey='email'
      loading={!pageReady}
      pagination={false}
      dataSource={customers}
    >
      <Customers.Column
        key='joined'
        title='Joined'
        dataIndex='created_at'
        render={val => val ? moment(val).format('M.D.YY') : '-'}
      />
      <Customers.Column
        key='name'
        title='Name'
        dataIndex='name'
        render={(val, record) => (
          <span>
            {record.name}
            <small> {record.email}</small>
          </span>
        )}
      />
      <Customers.Column
        key='orders'
        title='Orders'
        dataIndex='orders'
        render={(val) => {
          if (!val) return false
          const total = reduce(val, (sum, val) => sum += parseInt(val.amount)/100, 0)
          return <Money value={total} />
        }}
      />
      <Customers.Column
        key='donations'
        title='Donations'
        dataIndex='donations'
        render={(val) => {
          if (!val) return false
          const total = reduce(val, (sum, val) => sum += parseInt(val.amount)/100, 0)
          return <Money value={total} />
        }}
      />
    </Customers.List>
  )
}

//-----------  Prop Types  -----------//

CustomersTable.propTypes = {
  customers: PropTypes.object.isRequired
}

//-----------  Export  -----------//

export default CustomersTable
