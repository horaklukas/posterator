// @flow

import { routerActions } from 'react-router-redux';

import {createRequestUrl, fetchJSON} from 'utils/loadData';
import {PostersMap} from 'models/posters';
import * as constants from './postersConstants';

export function loadPosters() {
  return function (dispatch) {
    const url = createRequestUrl({ type: 'posters' }), 
      done = (json) => dispatch(handlePostersLoaded(json)),
      fail = (err) => dispatch(handlePostersLoadFailed());

    return fetchJSON(url, done, fail);
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

    return dispatch(routerActions.push(`/edit/${posterId}`))  
  };
}

export const actionCreators = {
  selectPoster,
  loadPosters
};