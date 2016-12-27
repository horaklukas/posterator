import React from 'react';
import { Route, IndexRoute, Redirect } from 'react-router';

import App from './App';
//import FriendsView from 'features/friends/components/FriendsView';
import PosterSelectView from 'features/posters/components/PosterSelectView';
import EditorView from 'features/editor/components/EditorView';
import NotFoundView from 'components/NotFound';

export default (
  <Route path="/" component={App}>
    <IndexRoute component={PosterSelectView} />
    <Route path="edit/:posterId" component={EditorView} />
    <Route path="404" component={NotFoundView} />
    <Redirect from="*" to="404" />
  </Route>
);