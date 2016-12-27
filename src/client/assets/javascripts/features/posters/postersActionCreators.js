// @flow

import { routerActions } from 'react-router-redux';

import {PostersMap} from 'models/posters';
import * as constants from './postersConstants';

const PHP_BACKEND_URL = '../backend/get-data.php';

export function loadPosters() {
  return function (dispatch) {
    return fetch(`${PHP_BACKEND_URL}?type=posters`)
      .then(response => response.json())
      .then(json => dispatch(handlePostersLoaded(json)))
      .catch(ex => dispatch(handlePostersLoadFailed()));
  };
}

function handlePostersLoaded(posters: PostersMap) {
  return {
    type: constants.POSTERS_LOADED, 
    posters: posters
  };
}


function handlePostersLoadFailed() {
  return {
    type: constants.POSTERS_LOAD_FAILED,
    message: 'Loading posters failed'
  };
}

function selectPoster (posterId: string) {
  return function (dispatch) {
    dispatch({
      type: constants.POSTER_SELECTED, 
      posterId: posterId
    });

    dispatch(routerActions.push(`/edit/${posterId}`))  

    return loadPosterTitles(posterId, dispatch);
  };
}

function loadPosterTitles(posterId, dispatch) {
  return fetch(`${PHP_BACKEND_URL}?type=titles&poster=${posterId}`)
    .then(response => response.json())
    .then(json => dispatch(handleTitlesLoaded(json)))
    .catch(ex => dispatch(handleTitlesLoadFailed()));
}

function handleTitlesLoaded(titles) {
  return {
    type: constants.TITLES_LOADED, 
    titles: titles
  };
}

function handleTitlesLoadFailed() {
  return {
    type: constants.TITLES_LOAD_FAILED,
    message: 'Loading titles failed'
  };
}

function addNewTitle() {
  return {
    type: constants.ADD_NEW_TITLE
  };
}

export const actionCreators = {
  selectPoster,
  addNewTitle,
  loadPosters
};