import {BASE_URL} from './config_request';

function  getJwt() {
  return `JWT ${localStorage.getItem('jwt')}`
}
// HTTP REQUESTS

export const List = {
  all () {
    return fetch(
      `${BASE_URL}/api/v1/lists`,
      {
        headers: {
          'Authorization': getJwt()
        }
      }
    )
      .then(res => res.status === 200 ? res.json() : [])
  },
  get (id) {
    return fetch(
      `${BASE_URL}/api/v1/lists/${id}`,
      {
        headers: {
          'Authorization': getJwt()
        }
      }
    )
      .then(res => res.json())
  },
  create (params) {
    return fetch(
      `${BASE_URL}/api/v1/lists`,
      {
        method: 'POST',
        headers: {
          'Authorization': getJwt(),
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(params)
      }
    )
    .then(res => res.json());
  },
  update (id, params) {
    return fetch(
      `${BASE_URL}/api/v1/lists/${id}`,
      {
        method: 'PATCH',
        headers: {
          'Authorization': getJwt(),
          'Content-Type': 'application/json'
        },
        body: JSON.stringify(params)
      }
    )
    .then(res => res.json());
  },
  destroy (id) {
    return fetch(
      `${BASE_URL}/api/v1/lists/${id}`,
      {
        method: 'DELETE',
        headers: {
          'Authorization': getJwt()
        }
      }
    )
      .then(res => res.json())
  }
}
