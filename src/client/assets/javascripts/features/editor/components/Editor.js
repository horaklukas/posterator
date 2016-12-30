import React, { Component } from 'react';

import Panel from './Panel/Panel';
import Canvas from './Canvas';

const DEFAULT_WIDTH = 1024;
const DEFAULT_HEIGHT = 768;

export default class Editor extends Component {
  render() {
    const props = this.props;
    let {titles, hoveredTitle} = props.editor,
      {poster} = props,
      canvasSize = poster 
        ? { width: poster.width, height: poster.height } 
        : { width: DEFAULT_WIDTH, height: DEFAULT_HEIGHT };
    let styles = {
      height: canvasSize.height
    };
    
    return (
      <div className="editor" style={styles} >
        <Canvas url={poster && poster.url} size={canvasSize} titles={titles} hoveredTitle={hoveredTitle} />

        <Panel {...props.editor} canvasWidth={canvasSize.width} 
          generatePoster={this.props.actions.generatePoster} />
      </div>
    );
  }
}
