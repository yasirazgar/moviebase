
import React, { Component } from 'react';
import ReactDOM from 'react-dom';
import { Provider } from 'react-redux';
import { createStore } from 'redux';

import App from './App.jsx'
import reducers from '../reducers'
import { buildTranslations } from '../actions'
import { DEFAULT_LOCALE } from './constants.js'

const store = createStore(reducers);
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