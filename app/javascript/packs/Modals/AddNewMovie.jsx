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

import { addNewMovie } from '../../actions'

const AddNewMovie = ({addNewMovie, show, handleClose, translations}) => {

  const [title, setTitle] = useState('');
  const handleTitleChange = (event) => { setTitle(event.target.value); }
  const [description, setDescription] = useState('');
  const handleDescriptionChange = (event) => { setDescription(event.target.value); }

  const handleSubmit = () => {
    addNewMovie({movie: {title, description}});
    handleClose();
  }

  return (
    <Modal show={show} onHide={handleSignupClose} animation={false}>
      <Modal.Header closeButton>
        <Modal.Title>Signup</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formBasicEmail">
            <Form.Control type="name" placeholder="Name" onChange={handleTitleChange} />
          </Form.Group>

          <Form.Group controlId="formBasicDescription">
            <Form.Control type="password" placeholder="Confirm Password" onChange={handleDescriptionChange}/>
          </Form.Group>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={handleClose}>
          Close
        </Button>
        <Button variant="primary" onClick={handleSubmit}>
          Save Changes
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

export default connect(mapStateToProps, {addNewMovie})(AddNewMovie)



