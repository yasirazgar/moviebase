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

import { updateMovie } from '../../actions'

const UpdateMovie = ({categories, updateMovie, show, handleClose, translations, movie}) => {

  const [title, setTitle] = useState(movie[1]);
  const handleTitleChange = (event) => { setTitle(event.target.value); }
  const [description, setDescription] = useState(movie[2]);
  const handleDescriptionChange = (event) => { setDescription(event.target.value); }
  const [category_id, setCategory] = useState(movie[4]);
  const handleCategoryChange = (event) => {
    setCategory(event.target.selectedOptions[0].getAttribute('id'));
  }

  const handleSubmit = () => {
    updateMovie(movie[0], {movie: {title, description, category_id}});
    handleClose();
  }

  const categoriesOptions = Object.keys(categories).map((cat_id, index) => {
    return(<option selected={(cat_id == category_id)} key={cat_id} id={cat_id}>{categories[cat_id][0]}</option>)
  })

  return (
    <Modal show={show} onHide={handleClose} animation={false}>
      <Modal.Header closeButton>
        <Modal.Title>{translations.update_movie}</Modal.Title>
      </Modal.Header>
      <Modal.Body>
        <Form>
          <Form.Group controlId="formBasicTitle">
            <Form.Control type="name" placeholder={translations.title} value={title} onChange={handleTitleChange} />
          </Form.Group>
          <Form.Control as="select" onChange={handleCategoryChange}>
            {categoriesOptions}
          </Form.Control>

          <Form.Group controlId="formBasicDescription">
            <Form.Control as="textarea" placeholder={translations.description} value={description} onChange={handleDescriptionChange}/>
          </Form.Group>
        </Form>
      </Modal.Body>
      <Modal.Footer>
        <Button variant="secondary" onClick={handleClose}>
          {translations.close}
        </Button>
        <Button variant="primary" onClick={handleSubmit}>
          {translations.update}
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

export default connect(mapStateToProps, {updateMovie})(UpdateMovie)
