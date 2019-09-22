import axios from 'axios'

export default axios.create({
  baseURL: 'http://localhost:3000',
  headers: {
    'Content-Type': 'application/json',
    // 'X-CSRF-Token': document.getElementsByName('csrf-token')[0].content,
    'Authorization': (window.localStorage.getItem('jwt') ? `Bearer ${window.localStorage.getItem('jwt')}` : '')
  }
});