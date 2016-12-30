import {map as _map} from 'lodash';

const PHP_BACKEND_URL = '../backend/get-data.php';

export function createRequestUrl(params: {[key: string]: string}) {
	let paramsString = _map(params, (val, key) => `${key}=${val}`).join('&');
	
	return `${PHP_BACKEND_URL}?${paramsString}`;
}

export function fetchJSON(url, done, fail) {
	return fetch(url)
    .then(response => response.json())
    .then(done)
    .catch(fail);
}