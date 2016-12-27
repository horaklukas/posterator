import { combineReducers } from 'redux';
import { routerReducer as routing } from 'react-router-redux';

import postersReducer, { NAME as postersName } from 'features/posters';

export default combineReducers({
  routing,
  [postersName]: postersReducer
});
