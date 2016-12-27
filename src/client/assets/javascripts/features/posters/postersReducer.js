// @flow

import { State } from 'models/posters';
import * as postersConstants from './postersConstants';

// Define the initial state for `posters` module

const initialState: State = {
  selectedPosterId: null,
  posters: {},
  titles: {}
};

function getNewTitle() {
  return {
    position: {
      x: 10, 
      y: 10
    },
    angle: 0,
    text: 'Title',
    font: {
      size: 15, 
      family: 'Arial', 
      color: '#000000', 
      italic: false, 
      bold: false
    }
  };
}

export default function reducer(state: State = initialState, action: any = {}): State {

    switch(action.type) {
      case postersConstants.POSTER_SELECTED:
        return {
          ...state,
          selectedPosterId: action.posterId
        };

      case postersConstants.TITLES_LOADED:
        return {
          ...state,
          titles: action.titles
        };

      case postersConstants.POSTERS_LOADED:
        return {
          ...state,
          posters: action.posters
        };

      //case editorConstants.TITLE_MOVE:
        /*titleId = EditorStore.getDraggedTitleId()

        @titles[titleId].position = EditorStore.countTitlePosition(
          payload.x, payload.y
        )*/

      //case editorConstants.TITLE_TEXT_CHANGED:
        //return {
          //...state,
          //AppDispatcher.waitFor [EditorStore.dispatcherIndex]
          //titleId = EditorStore.getSelectedTitleId()

          //@titles[titleId].text = payload.text
        //}

      //case editorConstants.TITLE_FONT_CHANGED:
        //return {
          //...state,
          //AppDispatcher.waitFor [EditorStore.dispatcherIndex]
          //titleId = EditorStore.getSelectedTitleId()

          //@titles[titleId].font[payload.property] = payload.value
        //}

      //case editorConstants.TITLE_ANGLE_CHANGED:
        //return {
          //...state,
          //AppDispatcher.waitFor [EditorStore.dispatcherIndex]
          //titleId = EditorStore.getSelectedTitleId()

          //@titles[titleId].angle = payload.angle
        //}

      case postersConstants.ADD_NEW_TITLE:
        return {
          ...state,
          titles: state.titles.concat(getNewTitle())
        }

      default:
        return state;
    }
}