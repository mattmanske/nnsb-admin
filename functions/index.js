const Stripe = require("stripe");
const functions = require("firebase-functions");
const { defineString } = require("firebase-functions/params");

const STRIPE_SECRET_KEY = defineString("STRIPE_SECRET_KEY");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

exports.admin_get_orders = functions
  .runWith({ STRIPE_SECRET_KEY })
  .https.onRequest((req, res) => {
    res.set("Access-Control-Allow-Origin", "*");

    const stripe = Stripe(STRIPE_SECRET_KEY.value());

    return stripe.orders.list({}, (_err, orders) => res.send(orders));
  });

exports.admin_ship_order = functions
  .runWith({ STRIPE_SECRET_KEY })
  .https.onRequest((req, res) => {
    res.set("Access-Control-Allow-Origin", "*");

    const { status, orderID } = req.body;
    const stripe = Stripe(STRIPE_SECRET_KEY.value());

    return stripe.orders.update(orderID, { status }, (_err, _order) => {
      return stripe.orders.list({}, (_err, orders) => res.send(orders));
    });
  });
