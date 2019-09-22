import { combineReducers } from 'redux';
import { BUILD_TRANSLATIONS, FETCH_MOVIES } from '../packs/constants'

const INITIAL_TRANSLATIONS = {}
const translations = (state=INITIAL_TRANSLATIONS, action) => {
  if (action.type == BUILD_TRANSLATIONS){
    return action.payload
  }

  return state;
}

const INITIAL_MOVIES = []
const movies = (state=INITIAL_MOVIES, action) => {
  if (action.type === FETCH_MOVIES) {
    return action.payload.data.movies;
  }

  return state;
}

export default combineReducers({
  translations,
  movies
});