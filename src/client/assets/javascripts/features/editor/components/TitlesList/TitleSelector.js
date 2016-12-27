import React, { Component, PropTypes } from 'react';
//actions = require '../../actions/editor-actions-creators'

export default class TitleSelector extends Component {
  static propTypes = {
    label: PropTypes.string
  };

  handleMouseOver() {
    //actions.hoverTitle(this.props.id);
  }

  handleMouseOut() {
    //actions.unhoverTitle();
  }

  handleClick() {
    //actions.selectTitle(this.props.id);
  }

  render() {
    return (
      <span className="title" onClick={this.handleClick} onMouseOver={this.handleMouseOver} onMouseOut={this.handleMouseOut}>{this.props.label}</span>  
    );
  }
}