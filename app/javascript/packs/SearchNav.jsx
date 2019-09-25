// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux';
import { useEffect, useState } from 'react';

import Container from 'react-bootstrap/Container';
import Navbar from 'react-bootstrap/Navbar';
import Nav from 'react-bootstrap/Nav';
import NavDropdown from 'react-bootstrap/NavDropdown';
import Dropdown from 'react-bootstrap/Dropdown';
import Form from 'react-bootstrap/Form';
import FormControl from 'react-bootstrap/FormControl';
import Button from 'react-bootstrap/Button';
import ButtonToolbar from 'react-bootstrap/ButtonToolbar';

import AddNewMovieModal from './Modals/AddNewMovie';

import { fetchRatings, fetchCategories, searchMovies } from '../actions'

const SearchNav = (props) => {
  const {
    user, fetchRatings, fetchCategories, searchMovies,
    categories, ratings, translations
  } = props;

  useEffect(() => {
    fetchCategories();
    fetchRatings();
  }, [])

  const [category, setCategory] = useState({});
  const handleCategoryChange = (eventKey, event) => {
    const selected = (eventKey == category.id) ? {} : {id: eventKey, display: event.target.text}
    setCategory(selected);
  }

  const [rating, setRating] = useState({});
  const handleRatingChange = (eventKey, event) => {
    const selected = (eventKey == rating.id) ? {} : {id: eventKey, display: event.target.text}
    setRating(selected);
  }

  const [term, setTerm] = useState(null);
  const handleTermChange = (event) => setTerm(event.target.value);

  const categoriesList = Object.keys(categories).map((category_id, index) => {
    let cat = categories[category_id],
        cat_display = `${cat[0]} (${cat[1]})`;

    return(
      <NavDropdown.Item key={category_id} active={category.id === category_id} eventKey={category_id}>{cat_display}</NavDropdown.Item>
    );
  })

  const ratingsList = Object.keys(ratings).map((rating_id, index) => {
    let rat = ratings[rating_id],
        rating_display = `${rat[0]} (${rat[1]})`;
    return(
      <NavDropdown.Item key={rating_id} active={rating.id === rating_id} eventKey={rating_id}>{rating_display}</NavDropdown.Item>
    );
  })

  const handleSubmit = event => {
    let data = {}
    if (category.id){
      data['category_id'] = category.id
    }
    if (term){
      data['term'] = term
    }

    if (rating.id){
      data['rating'] = rating.id
    }
    searchMovies(data);
    event.preventDefault();
  }

  const [showAddMovie, setShowAddMovie] = useState(false);
  const handleAddMovieClose = () => setShowAddMovie(false);
  const handleAddMovieShow = () => setShowAddMovie(true);

  return(
    <Navbar className="sub-nav" bg="light" variant="light" expand="lg" sticky={"top"}>
      {user && (<Button variant="primary" onClick={handleAddMovieShow} >{translations.add_new}</Button>)}
      <AddNewMovieModal show={showAddMovie} handleClose={handleAddMovieShow}/>
      <Navbar.Toggle aria-controls="basic-navbar-nav" />
      <Navbar.Collapse id="basic-navbar-nav">
        <Form _ref="term" className="ml-auto" inline onSubmit={handleSubmit}>
          <Nav>
            <NavDropdown active={category} title={category.display || translations.category} onSelect={handleCategoryChange} id="basic-nav-dropdown">
              {categoriesList}
            </NavDropdown>
            <NavDropdown active={rating} title={rating.display || translations.rating} onSelect={handleRatingChange} id="basic-nav-dropdown">
              {ratingsList}
            </NavDropdown>
          </Nav>
          <FormControl type="text" placeholder={translations.title} onChange={handleTermChange} className="mr-sm-2" />
          <Button type="submit" variant="outline-success">{translations.search}</Button>
        </Form>
      </Navbar.Collapse>
    </Navbar>
  )
}

const mapStateToProps = state => {
  return {
    translations: state.translations,
    categories: state.categories,
    ratings: state.ratings,
    user: state.user
  }
}

export default connect(mapStateToProps, {fetchCategories, fetchRatings, searchMovies})(SearchNav)
