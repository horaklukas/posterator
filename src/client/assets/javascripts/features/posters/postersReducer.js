// @flow

import { State } from 'models/posters';
import * as postersConstants from './postersConstants';

// Define the initial state for `posters` module

const initialState: State = {
  selectedPosterId: null,
  posters: {}
};

export default function reducer(state: State = initialState, action: any = {}): State {

    switch(action.type) {
      case postersConstants.POSTER_SELECTED:
        return {
          ...state,
          selectedPosterId: action.posterId
        };

      case postersConstants.POSTERS_LOADED:
        return {
          ...state,
          posters: action.posters
        };

      default:
        return state;
    }
}