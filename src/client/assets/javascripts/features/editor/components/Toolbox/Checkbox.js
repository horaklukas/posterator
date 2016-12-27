import React, { Component } from 'react';

export default class Checkbox extends Component{
  handleCheck() {
    this.props.onChange(this.props.name, !this.props.checked);
  }

  render() {
    return (
      <div className="checkbox-container">
        <div className="checkbox" onClick={this.handleCheck}>
          {!!this.props.checked ? '✔' : ''}
        </div>
        <span className="label">{this.props.label}</span>
      </div>
    )
  }
}