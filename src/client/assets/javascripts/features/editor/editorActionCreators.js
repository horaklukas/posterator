// @flow

import * as constants from './editorConstants';
import {createRequestUrl, fetchJSON} from 'utils/loadData';

import * as WebFontLoader from 'webfontloader';
import fontsList from 'json!../../../data/fontsList.json';

function loadTitles() {
  return function(dispatch) {
    const url = createRequestUrl({ type: 'titles' }), 
      done = (json) => dispatch(handleTitlesLoaded(json)),
      fail = (err) => dispatch(handleTitlesLoadFailed()); 
    
    return fetchJSON(url, done, fail);
  }
}

/*function loadPosterTitles(posterId) {
  return function(dispatch) {
    const url = createRequestUrl({ type: 'titles', poster: posterId }), 
      done = (json) => dispatch(handleTitlesLoaded(json)),
      fail = (err) => dispatch(handleTitlesLoadFailed()); 
    
    return fetchJSON(url, done, fail);
  }
}*/

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

function startTitleMove(titleId, x, y, titleX, titleY) {
  return {
    type: constants.TITLE_MOVE_START, 
    titleId: titleId, 
    position: {
      x: x, 
      y: y
    },
    startPosition: {
      x: titleX, 
      y: titleY
    }
  };
}

function titleMove(x, y) {
  return {
    type: constants.TITLE_MOVE, 
    position: {
      x: x, 
      y: y
    }
  };
}

function stopTitleMove(titleId) {
  return {
    type: constants.TITLE_MOVE_STOP
  }
};

function selectTitle(titleId) {
  return {
    type: constants.TITLE_SELECT, 
    titleId: titleId
  };
}

function unselectTitle(titleId) {
  return {
    type: constants.TITLE_UNSELECT
  };
}

function hoverTitle(titleId) {
  return {
    type: constants.TITLE_HOVER_IN_LIST, 
    titleId: titleId
  };
}

function unhoverTitle() {
  return {
    type: constants.TITLE_UNHOVER_IN_LIST
  };
}

function changeTitleText(text) {
  return {
    type: constants.TITLE_TEXT_CHANGED, 
    text: text
  };
}

function changeTitleFont(property, value) {
  return {
    type: constants.TITLE_FONT_CHANGED, 
    property: property, 
    value: value
  };
}

function changeTitleAngle(angle) {
  return {
    type: constants.TITLE_ANGLE_CHANGED, 
    angle: angle
  };
}

function generatePoster() {
  return {
    type: constants.GENERATE_POSTER
  };
}

function loadFonts() {
  return function(dispatch) {
    getFontsList(function(families) {
      let WebFontConfig = {
        google: {
          families: families
        },
        //loading: -> console.log 'All fonts loading'
        active: function() {
          dispatch({
            type: constants.FONTS_LOADED, 
            fonts: families
          });
        }
        //inactive: -> console.log 'All fonts inactive'
        //fontloading: (familyName, fvd) -> console.log 'Font', familyName, 'loading'
        //fontactive: (familyName, fvd) -> console.log 'Font', familyName, 'active'
        //fontinactive: (familyName, fvd) -> console.log 'Font', familyName, 'inactive'
      };
  
      WebFontLoader.load(WebFontConfig);
    });
  };
}

function getFontsList(cb) {
  //getJSON('./fonts-list.json').then cb, (err) -> console.log 'Failed to load fonts'
  cb(fontsList.sort())
}

export const actionCreators = {
  loadFonts,
  loadTitles,
  //loadPosterTitles,
  startTitleMove,
  titleMove,
  stopTitleMove,
  selectTitle,
  unselectTitle,
  hoverTitle,
  unhoverTitle,
  changeTitleText,
  changeTitleFont,
  changeTitleAngle,
  generatePoster
};