"use latest"

//-----------  Imports  -----------//

const Stripe = require('stripe@4.14.0')

//-----------  Export  -----------//

module.exports = (ctx, cb) => {

  const { STRIPE_SECRET_KEY } = ctx.data

  //-----------  Definitions  -----------//

  const stripe = Stripe(STRIPE_SECRET_KEY)

  //-----------  Processing  -----------//

  return stripe.orders.list({}, (err, orders) => {
    return (err) ? cb(err) : cb(null, orders)
  })
}
