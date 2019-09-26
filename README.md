# README

Application for creating, listing and rating movies.

Tried to keep the application simple by avoiding additional gems/libraries and queuing/caching mechanisms. 


## Tech Stack
Backend:
	Api architecture style - RESTful api
	Language/Framework - Rails (6.0.0) - Ruby (2.6.4)
	Unit testing framework - Minitest - 
    rails test - runs all unit test

Front-end: 
  React-16.9, Bootstrap-4.3.1
  Unit testing framework - Jest, enzyme - 
    yarn jest - runs all unit test

Database:
  Postgresql - 9.6
  Database setup rails db:create db:migrate db:seed

Currently the app is deployed to heroku - https://movibase.herokuapp.com

Existing user's in db via seed
email: yasir@risk.com, password: PassworD@55
email: azgar@risk.com, password: PassworD@55
email: randy@risk.com, password: PassworD@55
