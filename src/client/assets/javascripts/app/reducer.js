import { combineReducers } from 'redux';
import { routerReducer as routing } from 'react-router-redux';

import postersReducer, { NAME as postersName } from 'features/posters';
import editorReducer, { NAME as editorName } from 'features/editor';

export default combineReducers({
  routing,
  [postersName]: postersReducer,
  [editorName]: editorReducer
});
