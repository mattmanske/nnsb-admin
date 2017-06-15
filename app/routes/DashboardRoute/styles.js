//-----------  Imports  -----------//

import styled      from 'styled-components'

import PageWrapper from 'components/PageWrapper'

import vars        from 'styles/variables'

//-----------  Sponsors Route  ----------- */

const Page = styled(PageWrapper)`
  > div {
    display         : flex;
    justify-content : space-between;
  }

  h3 {
    margin-bottom: 1rem;
  }
`

const Albums = styled.div`
  flex: 1 1 33%;
`

const Album = styled.div`
  clear: both;

  img {
    float  : left;
    height : auto;
    margin : 0 1rem 1rem 0;
    width  : 5rem;
  }
`

const Customers = styled.div`
  flex: 1 1 67%;
`

//-----------  Exports  ----------- */

export default { Page, Albums, Album, Customers }
