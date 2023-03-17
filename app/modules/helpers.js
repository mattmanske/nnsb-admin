//-----------  Imports  -----------//

import moment from "moment";

import * as firebase from "firebase";
import { SubmissionError } from "redux-form";
import { select } from "redux-saga/effects";
import ReduxSagaFirebase from "redux-saga-firebase";

// -----------  Firebase  -----------//

export const RSF_SITE = new ReduxSagaFirebase(
  firebase.initializeApp(
    {
      apiKey: process.env.SITE_FIREBASE_API_KEY,
      authDomain: `${process.env.SITE_FIREBASE_PROJECT_ID}.firebaseapp.com`,
      databaseURL: `https://${process.env.SITE_FIREBASE_PROJECT_ID}.firebaseio.com`,
    },
    "site"
  )
);

export const RSF_ADMIN = new ReduxSagaFirebase(
  firebase.initializeApp(
    {
      apiKey: process.env.ADMIN_FIREBASE_API_KEY,
      authDomain: `${process.env.ADMIN_FIREBASE_PROJECT_ID}.firebaseapp.com`,
      databaseURL: `https://${process.env.ADMIN_FIREBASE_PROJECT_ID}.firebaseio.com`,
    },
    "admin"
  )
);

//-----------  Remote Helpers  -----------//

const SYNC = "SYNC";
const REQUEST = "REQUEST";
const SUCCESS = "SUCCESS";
const FAILURE = "FAILURE";

export const action = (type, payload = {}) => ({ type, ...payload });

export const timestamp = (object, status = false) => {
  const createdAt = moment.utc().toString();
  const updatedAt = moment.utc().toString();

  if (status) return { createdAt, status: "draft", ...object, updatedAt };
  else return { createdAt, ...object, updatedAt };
};

export const createActionConstants = (base, types = []) => {
  const typeArr = [SYNC, REQUEST, SUCCESS, FAILURE, ...types];
  const res = {};

  typeArr.forEach((type) => (res[type] = `${base}_${type}`));
  return res;
};

// TODO: Protect against duplicate channel syncing...

//-----------  Webtasks  -----------//

export const prodQuery = () => {
  return "production" == process.env.NODE_ENV ? { prod: true } : {};
};

export const webtaskUrl = (taskName) => {
  return `${process.env.FUNCTIONS_SUBDOMAIN}/${taskName}/`;
};

//-----------  Redux API  -----------//

export const reduxStatus = (lower = 200, upper = 399) => {
  return function (req, next) {
    return next().then((res) => {
      if (res.status >= lower && res.status <= upper) return res;
      else throw new SubmissionError({ _error: res.body });
    });
  };
};
