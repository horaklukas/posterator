import React, { Component } from 'react';

import TitlesList from './TitlesList/TitlesList';
import Toolbox from './Toolbox/Toolbox';
import Canvas from './Canvas';

//actions = require '../actions/editor-actions-creators'

export default class Editor extends Component {
  handleGenerate() {
    //actions.generatePoster();
  }

  createToolbox(title, leftPosition, fonts) {
    return (
      <Toolbox left={leftPosition} text={title.text} font={title.font}
        titleAngle={title.angle} fonts={fonts} />
    );
  }

  render() {
    let {poster, titles, selectedTitle, hoveredTitle, fonts} = this.props,
      styles = { left: poster.width },
      titleToEdit = titles && titles[selectedTitle];

    let panelContent = titleToEdit 
      ? this.createToolbox(titleToEdit, poster.width, fonts)
      : titles 
        ? <TitlesList titles={titles} /> 
        : null;

    return (
      <div className="editor" style={{height: poster.height}} >
        <Canvas poster={poster} titles={titles} hoveredTitle={hoveredTitle} />

        <div className="panel" style={styles}>
          <button className="btn btn-primary generate" disabled={!titles}
            onClick={this.handleGenerate}>Generate poster</button>

          {panelContent}
        </div>
      </div>
    );
  }
}
