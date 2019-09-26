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

import { addMovie } from '../../actions'

const AddMovie = ({categories, addMovie, show, handleClose, translations}) => {

  const [title, setTitle] = useState();
  const handleTitleChange = (event) => { setTitle(event.target.value); }
  const [description, setDescription] = useState();
  const handleDescriptionChange = (event) => { setDescription(event.target.value); }
  const [category_id, setCategory] = useState();
  const handleCategoryChange = (event) => {
    setCategory(event.target.selectedOptions[0].getAttribute('id'));
  }

  const handleSubmit = () => {
    addMovie({movie: {title, description, category_id}});
    handleClose();
  }

  const categoriesOptions = Object.keys(categories).map((category_id, index) => {
    return(<option key={category_id} id={category_id}>{categories[category_id][0]}</option>)
  })

  return (
    <Modal show={show} onHide={handleClose} animation={false}>
      <Modal.Header closeButton>
        <Modal.Title>{translations.add_new}</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formBasicTitle">
            <Form.Control type="name" placeholder={translations.title} onChange={handleTitleChange} />
          </Form.Group>
          <Form.Control as="select" onChange={handleCategoryChange}>
            {categoriesOptions}
          </Form.Control>

          <Form.Group controlId="formBasicDescription">
            <Form.Control as="textarea" placeholder={translations.description} onChange={handleDescriptionChange}/>
          </Form.Group>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={handleClose}>
          {translations.close}
        </Button>
        <Button variant="primary" onClick={handleSubmit}>
          {translations.add}
        </Button>
      </Modal.Footer>
    </Modal>
  )
}

const mapStateToProps = state => {
  return {
    translations: state.translations,
    categories: state.categories
  }
}

export default connect(mapStateToProps, {addMovie})(AddMovie)
