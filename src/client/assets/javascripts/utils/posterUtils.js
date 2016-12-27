//constants = require '../constants/poster-constants'
import {actionCreators} from '../features/posters';

export function loadPosterTitles(posterId) {
  //getJSON(`${PHP_BACKEND_URL}?type=titles&poster=${posterId}`)
    //.done(handleTitlesLoaded)
    //.fail(handleTitlesLoadFailed);
}

function handleTitlesLoaded(titles) {
  //AppDispatcher.dispatch({
    //type: constants.TITLES_LOADED, 
    //titles: titles
  //});
}

function handleTitlesLoadFailed() {
  //AppDispatcher.dispatch({
    //type: constants.TITLES_LOAD_FAILED
    //message: 'Loading titles failed'
  //});
} 