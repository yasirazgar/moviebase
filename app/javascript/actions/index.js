import loadTranslations from '../i18n'
import * as Actions from '../packs/constants/actions'
import moviesRequest from '../apis/moviesRequest'
import { userService } from '../services/user'

export const buildTranslations = (locale = 'en') => ({
  type: Actions.BUILD_TRANSLATIONS,
  payload: loadTranslations(locale)
})

export const fetchMovies = data => async dispatch => {
  const response = await moviesRequest.get('/movies.json', {params: data});

  dispatch({type: Actions.FETCH_MOVIES, payload: {response: response}})
}

export const fetchRatings = () => async dispatch => {
  const response = await moviesRequest.get('/ratings.json');

  dispatch({type: Actions.FETCH_RATINGS, payload: response})
}

export const fetchCategories = () => async dispatch => {
  const response = await moviesRequest.get('/categories.json');

  dispatch({type: Actions.FETCH_CATEGORIES, payload: response})
}

export const searchMovies = data => async dispatch => {
  const response = await moviesRequest.get('/movies/search.json', {params: data});

  dispatch({type: Actions.SEARCH_MOVIES, payload: {response: response, params: data}})
}

// export const setPage = data => {
//   dispatch({type: Actions.SET_PAGE, payload: data})
// }

export const login = data => async dispatch => {
  let response, error;
  try {
    response = await moviesRequest.post('/login.json', data);
  } catch (error) {
    response = error.response;
  }

  userService.login(dispatch, response)
}

export const signup = data => async dispatch => {
  let response, error;
  try {
    response = await moviesRequest.post('/users.json', data);
  } catch (error) {
    response = error.response;
  }

  userService.signup(dispatch, response)
}

export const logout = () => {
  userService.logout
  return({type: Actions.LOGOUT})
}

export const addMovie = data => async dispatch => {
  const response = await moviesRequest.post('/movies.json', data);

  dispatch({type: Actions.ADD_MOVIE, payload: response})
}
