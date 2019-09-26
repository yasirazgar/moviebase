// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux';
import { useState } from 'react'

import Accordion from 'react-bootstrap/Accordion';
import Card from 'react-bootstrap/Card';
import Button from 'react-bootstrap/Button';
import Pagination from 'react-bootstrap/Pagination';

import { updateMovie, deleteMovie } from '../actions'

import EditMovieModal from './Modals/EditMovie';

const Movie = ({user, movie, updateMovie, deleteMovie, translations}) => {
  const handleEdit = (event) => {
    const id = event.target.getAttribute("id");
    updateMovie(id, data);

    event.preventDefault();
    event.stopPropagation();
  }
  const handleDelete = (event) => {
    const id = event.target.getAttribute("id");
    deleteMovie(id);

    event.preventDefault();
    event.stopPropagation();
  }

  const [showUpdateMovie, setShowUpdateMovie] = useState(false);
  const handleUpdateMovieClose = () => setShowUpdateMovie(false);
  const handleUpdateMovieShow = () => setShowUpdateMovie(true);

  let actions
  if (user && (movie[6] == user['id'])){
    actions = (
      <>
        <span className="margin" id={movie[0]} onClick={handleDelete}> {movie[7]} </span>
        <span className="margin fa fa-pencil" id={movie[0]} onClick={handleUpdateMovieShow} />
        <span className="margin fa fa-trash" id={movie[0]} onClick={handleDelete} />
      </>
    )
  }

  return (
  <Card >
    <Card.Header>
      <Accordion.Toggle as={Card.Header} variant="link" eventKey={movie[0]}>
        <span>
          {movie[1]}
        </span>

        <span className="float-right">
          {actions}
          <span className="margin"> {movie[3] || 'NR'} </span>
        </span>
      </Accordion.Toggle>
    </Card.Header>
    <Accordion.Collapse eventKey={movie[0]}>
       <Card.Body>
        <div>
          {translations.category}: {movie[5]}
        </div>
          {translations.description}: {movie[5]}
       </Card.Body>
    </Accordion.Collapse>
    <EditMovieModal handleClose={handleUpdateMovieClose} show={showUpdateMovie} movie={movie}/>
  </Card>
)}

const mapStateToProps = state => {
  return {
    translations: state.translations,
    user: state.user
  }
}

export default connect(mapStateToProps, {deleteMovie, updateMovie})(Movie)

