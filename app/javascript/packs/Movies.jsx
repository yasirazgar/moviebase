// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { connect } from 'react-redux';
import { useEffect } from 'react';
import Accordion from 'react-bootstrap/Accordion';
import Card from 'react-bootstrap/Card';
import Button from 'react-bootstrap/Button';
import Pagination from 'react-bootstrap/Pagination';

import { fetchMovies } from '../actions'

import Movie from './Movie'
import Paginator from './Paginator'

const Movies = ({movies, translations, fetchMovies}) => {

  useEffect(() => {
    fetchMovies();
  }, [])

  const moviesRow = movies.map((movie, index) => {
    return(
      <Movie key={movie[0]} movie={movie}/>
    )
  })

  return (
    <div className='movies-wrapper'>
      <Accordion >
        {moviesRow}
      </Accordion>
      <Paginator />
    </div>
  )
}

const mapStateToProps = state => {
  return {
    translations: state.translations,
    movies: state.movies
  }
}

export default connect(mapStateToProps, { fetchMovies })(Movies)

