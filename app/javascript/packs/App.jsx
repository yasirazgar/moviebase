// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { connect } from 'react-redux';

import Container from 'react-bootstrap/Container';
import Row from 'react-bootstrap/Row';
import Col from 'react-bootstrap/Col';
import Alert from 'react-bootstrap/Alert';

import Movies from './Movies';
import MainNav from './MainNav';
import SearchNav from './SearchNav';
import LoginAlert from './LoginAlert';

import './Main.scss'

const App = ({translations}) => (
  <div>
    <MainNav />
    <Container>
      <Row>
        <Col>
          <SearchNav />
          <br/>
          <LoginAlert />
          <Movies />
        </Col>
      </Row>
    </Container>
  </div>
)

const mapStateToProps = state => {
  return {
    translations: state.translations
  }
}

export default connect(mapStateToProps)(App)