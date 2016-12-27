import React, { Component } from 'react';

export default class FontSelector extends Component {
  handleChange({target}) {
    this.props.onChange('family', target.value);
  }

  createFontOption(fontName) {
    let style = { fontFamily: fontName },
      key = fontName.toLowerCase().replace(/\s/g, '_');

    return (
      <option style={style} value={fontName} key={key}>
        {fontName}
      </option>
    );
  } 

  render() {
    return (
      <div className="font-selector">
        <span className="label">Font family</span>
        <select value={this.props.selected} onChange={this.handleChange}>
          {this.props.fonts.map(this.createFontOption)}
        </select>
      </div>
    )
  }
}