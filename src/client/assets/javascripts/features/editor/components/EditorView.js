import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

//import { actionCreators as friendsActions, selector } from '../';
import Editor from './Editor';

//@connect(selector, (dispatch) => ({
  //actions: bindActionCreators(friendsActions, dispatch)
//}))

export default class EditorView extends Component {
  render() {
    return (
      <div>
        <Editor {...this.props} />
      </div>
    );
  }
}
