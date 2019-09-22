import { combineReducers } from 'redux';
import { BUILD_TRANSLATIONS } from '../packs/constants'

const INITIAL_TRANSLATIONS = {}
const translations = (state=INITIAL_TRANSLATIONS, action) => {
  if (action.type == BUILD_TRANSLATIONS){
    return action.payload
  }

  return state;
}

export default combineReducers({
  translations
});