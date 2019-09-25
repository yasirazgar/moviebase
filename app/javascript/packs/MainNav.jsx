// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux';

import Navbar from 'react-bootstrap/Navbar';
import Container from 'react-bootstrap/Container';
import Nav from 'react-bootstrap/Nav';
import NavItem from 'react-bootstrap/NavItem';
import Button from 'react-bootstrap/Button';
import ButtonToolbar from 'react-bootstrap/ButtonToolbar';
import Modal from 'react-bootstrap/Modal';

import SignupModal from './Modals/Signup';
import LoginModal from './Modals/Login';

import { logout } from '../actions'

import { useState } from 'react'

const MainNav = ({logout, user, translations}) => {
  const [showLogin, setShowLogin] = useState(false);
  const handleLoginClose = () => setShowLogin(false);
  const handleLoginShow = () => setShowLogin(true);
  const [showSignup, setShowSignup] = useState(false);
  const handleSignupClose = () => setShowSignup(false);
  const handleSignupShow = () => setShowSignup(true);

  let rightContent;
  if (user) {
    rightContent = (
      <>
        <NavItem>
          <Button variant="primary" className="mr-1" onClick={logout}>{translations.logout}</Button>

        </NavItem>
      </>
    )
  }
  else {
    rightContent = (
      <>
        <NavItem>
          <Button variant="primary" className="mr-1" onClick={setShowLogin}>{translations.login}</Button>
        </NavItem>
        <NavItem>
          <Button variant="primary" onClick={setShowSignup} >{translations.singup}</Button>
        </NavItem>
    </>
    )
  }

  return (
    <Navbar bg="dark" variant="dark" sticky={'top'} >
      <Nav >
        <Navbar.Brand href="/movies">MovieBase</Navbar.Brand>
      </Nav>

      <Nav className="ml-auto">
        {rightContent}
      </Nav>

      <LoginModal show={showLogin} handleLoginClose={handleLoginClose}/>

      <SignupModal show={showSignup} handleSignupClose={handleSignupClose}/>
    </Navbar>
  )
}

const mapStateToProps = state => {
  return {
    translations: state.translations,
    user: state.user
  }
}

export default connect(mapStateToProps, { logout })(MainNav)
