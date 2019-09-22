// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import PropTypes from 'prop-types'
import { connect } from 'react-redux';
import { useEffect } from 'react';
import Table from 'react-bootstrap/Table';

import { fetchMovies } from '../actions'

import './Movies.scss'

const Movies = ({movies, translations, fetchMovies}) => {

  useEffect(() => {
    fetchMovies();
  }, [])

  const moviesRow = movies.map((movie, index) => {
    return(
      <tr key={movie[0]}>
        <td> {movie[1]} </td>
        <td> {movie[2]} </td>
        <td> {movie[5]} </td>
        <td> {movie[3]} </td>
      </tr>
    )
  })

  return (
    <div className='movies-wrapper'>
      <Table striped bordered hover size="sm">
        <thead>
          <td> {translations.title} </td>
          <td> {translations.description} </td>
          <td> {translations.category} </td>
          <td> {translations.rating} </td>
        </thead>
        <tbody className='movie'>
          { moviesRow }
        </tbody>
      </Table>
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

