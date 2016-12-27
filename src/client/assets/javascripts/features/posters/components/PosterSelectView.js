import React, { Component } from 'react';
import { connect } from 'react-redux';
import { bindActionCreators } from 'redux';

import { actionCreators as postersActions, selector } from '../';
import {PosterSelect} from './PosterSelect';

@connect(selector, (dispatch) => ({
  actions: bindActionCreators(postersActions, dispatch)
}))

export default class PosterSelectView extends Component {
  render() {
    return (
      <div>
        <PosterSelect {...this.props} />
      </div>
    );
  }
}
