import { combineReducers } from 'redux';
import * as Actions from '../packs/constants/actions'

// Move this and all movie actions into separate service
const update_movie = (updated_movie, state) => {
  let movies = [...state];
  const updatedIndex = movies.findIndex(movie => movie[0] == updated_movie[0]);
  movies[updatedIndex] = updated_movie;

  return movies
};


const INITIAL_TRANSLATIONS = {}
const translations = (state=INITIAL_TRANSLATIONS, action) => {
  if (action.type === Actions.BUILD_TRANSLATIONS){
    return action.payload
  }

  return state;
}

const INITIAL_MOVIES = []
const movies = (state=INITIAL_MOVIES, action) => {
  switch(action.type){
    case Actions.FETCH_MOVIES:
    case Actions.SEARCH_MOVIES:
      return action.payload.response.data.movies;
    case Actions.ADD_MOVIE:
      return [action.payload.data.movie,...state];
    case Actions.DELETE_MOVIE:
      const movie_id = action.payload.data.movie_id
      const movs = state.filter(function(value, index, arr){
        return value[0] != movie_id;
      })
      return movs;
    case Actions.UPDATE_MOVIE:
      return update_movie(action.payload.data.movie, state);
    case Actions.RATE_MOVIE:
      return update_movie(action.payload.data.movie, state);
    default:
      return state;
  }
}

const INITIAL_RATINGS = {}
const ratings = (state=INITIAL_RATINGS, action) => {
  if (action.type === Actions.FETCH_RATINGS) {
    return action.payload.data.ratings;
  }

  return state;
}

const INITIAL_CATEGORIES = {}
const categories = (state=INITIAL_CATEGORIES, action) => {
  if (action.type === Actions.FETCH_CATEGORIES) {
    return action.payload.data.categories;
  }

  return state;
}

const INITIAL_HEADERS = {}
const headers = (state=INITIAL_HEADERS, action) => {
  switch(action.type){
    case Actions.FETCH_MOVIES:
    case Actions.SEARCH_MOVIES:
      return action.payload.response.headers;
    default:
      return state;
  }

  return state;
}

const page = (state=null, action) => {
  if (action.type === Actions.SET_PAGE) {
    return action.payload;
  }

  return state;
}

const searchParams = (state=null, action) => {
  if (action.type === Actions.SEARCH_MOVIES) {
    return action.payload.params;
  }
  return state;
}

const initialUser = JSON.parse(window.localStorage.getItem('user'))
const user = (state=initialUser, action) => {
  switch(action.type){
    case Actions.LOGIN:
    case Actions.SIGNUP:
      return action.payload.data.user;
    case Actions.LOGOUT:
      return null;
    default:
      return state;
  }
}

const errors = (state=null, action) => {
  if (action.payload && action.payload.data && action.payload.data.errors){
    return action.payload.data.errors;
  }
  return state;
}

const initialToken = window.localStorage.getItem('jwt')
const token = (state=initialToken, action) => {
  switch(action.type) {
    case Actions.LOGIN:
    case Actions.SIGNUP:
      return action.payload.data.jwt;
    case Actions.LOGOUT:
      return null;
    default:
      return state;
  }
}

export default combineReducers({
  translations,
  movies,
  ratings,
  categories,
  headers,
  page,
  searchParams,
  user,
  token,
  errors
});