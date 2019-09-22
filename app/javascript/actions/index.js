import loadTranslations from '../i18n'
import { BUILD_TRANSLATIONS, FETCH_MOVIES } from '../packs/constants'
import moviesRequest from '../apis/moviesRequest'

export const buildTranslations = (locale = 'en') => ({
  type: BUILD_TRANSLATIONS,
  payload: loadTranslations(locale)
})

export const fetchMovies = () => async dispatch => {
  const response = await moviesRequest.get('/movies.json');

  dispatch({type: FETCH_MOVIES, payload: response})
}