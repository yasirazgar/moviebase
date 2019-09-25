// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux';
import Accordion from 'react-bootstrap/Accordion';
import Card from 'react-bootstrap/Card';
import Button from 'react-bootstrap/Button';
import Pagination from 'react-bootstrap/Pagination';

const Movie = ({movie, translations}) => (
  <Card >
    <Card.Header>
      <Accordion.Toggle as={Card.Header} variant="link" eventKey={movie[0]}>
        <span>
          {movie[1]}
        </span>

        <span className="float-right">
          {movie[3] || 'NR'}
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
  </Card>
)

const mapStateToProps = state => {
  return {
    translations: state.translations
  }
}

export default connect(mapStateToProps)(Movie)

