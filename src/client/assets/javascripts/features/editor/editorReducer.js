// @flow

import { State } from 'models/editor';
import * as constants from './editorConstants';

const initialState: State = {
  fonts: [],
  selectedTitle: null,
  hoveredTitle: null,
  dragged: {},
  titles: []
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

  switch (action.type) {
      case constants.FONTS_LOADED:
        return {
          ...state,
          fonts: action.fonts
        };
  
      case constants.TITLES_LOADED:
        return {
          ...state,
          titles: action.titles
        };

      case constants.TITLE_MOVE_START:
        return {
          ...state,
          dragged: {
            id: action.titleId,
            position: action.position,
            initialPosition: action.startPosition
          }
        };
  
      case constants.TITLE_MOVE_STOP:
        return {
          ...state,
          dragged: {}
        };

      case constants.TITLE_SELECT:
        return {
          ...state,
          selectedTitle: action.titleId,
          hoveredTitle: null
        }
  
      case constants.TITLE_UNSELECT:
         return {
          ...state,
          selectedTitle: null
        };

      case constants.TITLE_HOVER_IN_LIST:
        return {
          ...state,
          hoveredTitle: action.titleId
        };

      case constants.TITLE_UNHOVER_IN_LIST:
        return {
          ...state,
          hoveredTitle: null
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

      case constants.ADD_NEW_TITLE:
        return {
          ...state,
          titles: state.titles.concat(getNewTitle())
        }

      default:
        return state;
  }
}
