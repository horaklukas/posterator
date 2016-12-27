import React, { Component } from 'react';
import ReactSlider from 'react-slider';

export default class HorizontalSlider extends Component {
  handleChange(value) {
    this.props.onChange(this.props.name, value);
  }

  render() {
    let {value, min, max, label} = this.props;

    return (
      <div className="slider-container">
        <span className="label">{label}</span>
        <ReactSlider value={value} orientation="horizontal" min={min} max={max}
          onChange={this.handleChange}>
          <div>{value}</div>
        </ReactSlider>
      </div>
    );
  }
}