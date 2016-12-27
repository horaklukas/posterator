import React, { Component, PropTypes } from 'react';

import TitleSelector from './TitleSelector';
//actions = require '../../actions/poster-actions-creators'

export default class TitlesList extends Component {
  static propTypes = {
    titles: PropTypes.array
  };

  createTitleSelector({text}, index) {
    return (
      <TitleSelector id={index} label={text} key={index} />
    );
  }

  createEmptyListMessage() {
    return (
      <p className="alert alert-info">
        <span className="glyphicon glyphicon-info-sign"></span>
        There are no existing titles for poster
      </p>
    );
  }

  render() {
    return (
      <div className="titles-list">
        {
          this.props.titles.length > 0 
            ? this.props.titles.map(this.createTitleSelector) 
            : this.createEmptyListMessage()
        }

        <button className="btn add" onClick={null/*actions.addNewTitle*/}>
          Add new title
        </button>
      </div>
    );
  }
}
