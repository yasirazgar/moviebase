// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux';
import Pagination from 'react-bootstrap/Pagination';

import { fetchMovies, searchMovies } from '../actions'

import { PAGE_LIMIT } from './constants'

const Paginator = (props) => {
  const {
    fetchMovies, searchMovies, translations, headers, searchParams
  } = props

  if (headers.total < 11){
    return null;
  }

  const current_page = parseInt(headers['current-page'])

  if (!current_page){
    return null;
  }
  const total = parseInt(headers['total'])
  const total_pages = total / PAGE_LIMIT
  const first_page = 1
  const prev_page = Math.max(first_page, (current_page - 1))
  const last_page = total_pages
  const next_page = Math.min(last_page, (current_page + 1))

  const range_start = Math.max(first_page, (current_page - 5))
  const range_end = Math.min(last_page, (current_page + 5))


  const clickHandler = (event) => {
    let page = event.target.getAttribute('page');

    if (searchParams){
      searchParams['page'] = page
      searchMovies(searchParams)
    }
    else {
      fetchMovies({page})
    }

    event.preventDefault();
  }

  let range = [
    <Pagination.First key={first_page - 1} page={first_page} onClick={clickHandler}/>,
    <Pagination.Prev key={first_page - 2} page={prev_page} onClick={clickHandler} />
  ];
  for (let number = range_start; number <= (range_end); number++) {
    range.push(
      <Pagination.Item key={number} active={number === current_page} page={number} onClick={clickHandler}>
        {number}
      </Pagination.Item>,
    );
  }
  range.push(<Pagination.Next key={last_page + 1} page={next_page} onClick={clickHandler}/>)
  range.push(<Pagination.Last key={last_page + 2} page={last_page} onClick={clickHandler}/>)
  return(
    <div>
      <Pagination>{range}</Pagination>
      <br />
    </div>
  );
}

const mapStateToProps = state => {
  return {
    translations: state.translations,
    headers: state.headers,
    searchParams: state.searchParams
  }
}

export default connect(mapStateToProps, {fetchMovies, searchMovies})(Paginator)

