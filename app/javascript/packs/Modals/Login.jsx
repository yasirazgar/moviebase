// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux';
import { useState } from 'react'

import Button from 'react-bootstrap/Button';
import ButtonToolbar from 'react-bootstrap/ButtonToolbar';
import Modal from 'react-bootstrap/Modal';
import Form from 'react-bootstrap/Form';

import { login } from '../../actions'

const Login = ({show, login, handleLoginClose, translations}) => {
  const [email, setEmail] = useState({});
  const handleEmailChange = (event) => { setEmail(event.target.value); }
  const [password, setPassword] = useState({});
  const handlePasswordChange = (event) => { setPassword(event.target.value); }

  const handleLogin = () => {
    handleLoginClose();
    login({email: email, password: password});

    window.location.reload();
  }

  return (
    <Modal show={show} onHide={handleLoginClose} animation={false}>
      <Modal.Header closeButton>
        <Modal.Title>{translations.login}</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formBasicEmail">
            <Form.Control type="email" placeholder={translations.email} onChange={handleEmailChange} />
          </Form.Group>

          <Form.Group controlId="formBasicPassword">
            <Form.Control type="password" placeholder={translations.password} onChange={handlePasswordChange}/>
          </Form.Group>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={handleLoginClose}>
          {translations.close}
        </Button>
        <Button variant="primary" onClick={handleLogin}>
          {translations.login}
        </Button>
      </Modal.Footer>
    </Modal>
  )
}

const mapStateToProps = state => {
  return {
    translations: state.translations
  }
}

export default connect(mapStateToProps, {login})(Login)
