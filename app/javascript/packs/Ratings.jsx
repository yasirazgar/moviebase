// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux';
import { useState } from 'react'

import { rateMovie } from '../actions'

const Ratings = ({user, movie, rateMovie, translations}) => {
  const [ratings, setRatings] = useState((movie[7] || 0));

  const handleEdit = (event) => {
    const rated = parseInt(event.target.getAttribute('rating'))

    setRatings(rated)
    const movie_id = movie[0];
    rateMovie(movie_id, {rating: rated});

    event.preventDefault();
    event.stopPropagation();
  }

  let stars = []
  if (ratings){
    let rating = 1;
    for(let i = rating; i <= ratings; i++) {
      stars.push(<span className="fa fa-star fa-lg rating-rated" rating={i} key={i} onClick={handleEdit} />)
    }
  }
  let rating = ratings + 1;
  for(let i = rating; i <= 5; i++ ) {
    stars.push(<span className="fa fa-star-o fa-lg" key={i} rating={i} onClick={handleEdit} />)
  }

  return stars;
}

const mapStateToProps = state => {
  return {
    translations: state.translations,
    user: state.user
  }
}

export default connect(mapStateToProps, {rateMovie})(Ratings)

