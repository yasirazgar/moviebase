
import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore, applyMiddleware } from 'redux';
import thunk from 'redux-thunk';
import 'bootstrap/dist/css/bootstrap.min.css';

import App from './App.jsx'
import reducers from '../reducers'
import { buildTranslations } from '../actions'
import { DEFAULT_LOCALE } from './constants.js'

const store = createStore(reducers, applyMiddleware(thunk));
store.dispatch(buildTranslations(DEFAULT_LOCALE))

const Home = props => (
  <Provider store={store}>
    <App />
  </Provider>
);

document.addEventListener('DOMContentLoaded', () => {
  ReactDOM.render(<Home />, document.querySelector('.app'))
})

export default Home