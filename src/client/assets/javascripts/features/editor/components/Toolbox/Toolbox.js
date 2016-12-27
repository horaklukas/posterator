import React, { Component } from 'react';

import HorizontalSlider from './HorizontalSlider';
import FontSelector from './FontSelector';
import Checkbox from './Checkbox';
import {ColorPicker} from './ColorPicker';

//actions = require '../../actions/editor-actions-creators'
//constants = require '../../constants/editor-constants'

export default class Toolbox extends Component {
  handleTextChange(e) {
    //actions.changeTitleText e.target.value
  }

  handleFontChange(property, value) {
    //actions.changeTitleFont property, value
  }

  handleChangeAngle(name, angle) {
    //actions.changeTitleAngle angle
  }

  handleColorChange(color) {
    //actions.changeTitleFont 'color', color
  }

  render() {
    let fontSelector = null,
      {fonts} = this.props,
      {family, size, bold, italic, color} = this.props.font;

    if (fonts) {
      fontSelector = <FontSelector fonts={fonts} selected={family} onChange={this.handleFontChange} />
    }

    return (
      <div className="toolbox">
        <span className="label">Text</span>
        <input type="text" className="text" value={this.props.text}
          onChange={this.handleTextChange} />

        {fontSelector}

        <HorizontalSlider name="size" value={size} label="Font size"
            min={10} max={100} onChange={this.handleFontChange} />
        <HorizontalSlider name="angle" value={this.props.titleAngle} label="Text rotation"
            min={0} max={360} onChange={this.handleChangeAngle} />

        <div>
          <Checkbox label="Bold" name="bold" checked={bold}
            onChange={this.handleFontChange} />

          <Checkbox label="Italic" name="italic" checked={italic}
            onChange={this.handleFontChange} />
        </div>

        <ColorPicker color={color} label="Font color" onChange={this.handleColorChange} />

      </div>
    );
  }
}