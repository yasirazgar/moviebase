import { LOGIN, SIGNUP, LOGOUT } from '../packs/constants/actions'

const login = (dispatch, response) => {
  if (response.status === 200){
    setLoginItems(response)
    dispatch({type: LOGIN, payload: response});
  }
}

const logout = () => {
  window.localStorage.removeItem('jwt');
  window.localStorage.removeItem('user');
}

const signup = (response, dispatch) => {
  if (response.status === 200){
    setLoginItems(response)
    dispatch({type: SIGNUP, payload: response});
  }
}

const setLoginItems = (response) => {
  window.localStorage.setItem('jwt', response.data.jwt)
  window.localStorage.setItem('user', JSON.stringify(response.data.user))

}

export const userService = {
    login,
    logout,
    signup
};