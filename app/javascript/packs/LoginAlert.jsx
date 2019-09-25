// Run this example by adding <%= javascript_pack_tag 'hello_react' %> to the head of your layout file,
// like app/views/layouts/application.html.erb. All it does is render <div>Hello React</div> at the bottom
// of the page.

import React from 'react'
import ReactDOM from 'react-dom'
import { connect } from 'react-redux';

import Alert from 'react-bootstrap/Alert';

const LoginAlert = ({user, translations}) => {
  if (user){
    return null;
  }
  return (
    <Alert variant='info' sticky={"top"}>
      {translations.login_alert}
    </Alert>
  )
}

const mapStateToProps = state => {
  return {
    translations: state.translations,
    user: state.user
  }
}

export default connect(mapStateToProps)(LoginAlert)