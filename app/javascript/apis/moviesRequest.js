import axios from 'axios'

export default axios.create({
  baseURL: (process.env.NODE_ENV !== 'production') ? 'http://localhost:3000' : 'https://movibase.herokuapp.com',
  headers: {
    'Content-Type': 'application/json',
    // 'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content,
    'Authorization': (window.localStorage.getItem('jwt') ? `Bearer ${window.localStorage.getItem('jwt')}` : '')
  }
});