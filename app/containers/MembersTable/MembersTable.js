//-----------  Imports  -----------//

import Members              from './styles'

import React, { PropTypes } from 'react'
import { Icon, Button }     from 'antd'

//-----------  Component  -----------//

const MembersTable = (props) => {
  const { data, error, isLoading, isWatching } = props.members

  function editIcon(val, record){
    return <a onClick={() => props.memberModal(record)}><Icon type='ellipsis' /></a>
  }

  return (
    <Members.Elem>
      <h4>NNSB Members</h4>

      <Members.List
        size='small'
        pagination={false}
        dataSource={data}
      >
        <Members.Column
          key='key'
          width={25}
          dataIndex='key'
          render={editIcon}
        />
        <Members.Column
          key='name'
          title='Nickname'
          dataIndex='name'
        />
        <Members.Column
          key='email'
          title='Email'
          dataIndex='email'
        />
        <Members.Column
          key='primary'
          title='Primary?'
          dataIndex='primary'
          render={(val) => val && <Icon type='check' />}
        />
      </Members.List>

      <Button
        icon='plus'
        type='primary'
        onClick={() => props.memberModal()}
      >
        Add New Member
      </Button>
    </Members.Elem>
  )
}

//-----------  Prop Types  -----------//

MembersTable.propTypes = {
  members     : PropTypes.object.isRequired,
  memberModal : PropTypes.func.isRequired,
}

//-----------  Export  -----------//

export default MembersTable
