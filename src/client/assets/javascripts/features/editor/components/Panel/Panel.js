import React, { Component } from 'react';

import TitlesList from '../TitlesList/TitlesList';
import Toolbox from '../Toolbox/Toolbox';

export default class Panel extends Component {
	static propTypes = {
		generatePoster: React.PropTypes.func.isRequired,
		titles: React.PropTypes.arrayOf(React.PropTypes.string),
		selectedTitle: React.PropTypes.string,
		fonts: React.PropTypes.arrayOf(React.PropTypes.string),
		canvasWidth: React.PropTypes.number
	}

  createToolbox(title, leftPosition, fonts) {
    return (
      <Toolbox left={leftPosition} text={title.text} font={title.font}
        titleAngle={title.angle} fonts={fonts} />
    );
  }

  render() {
  	const {selectedTitle, titles, canvasWidth} = this.props;
  	let styles = { left: canvasWidth },
      titleToEdit = titles && titles[selectedTitle];

  	let panelContent = titleToEdit 
      ? this.createToolbox(titleToEdit, canvasWidth, fonts)
      : titles 
        ? <TitlesList titles={titles} /> 
        : null;

		return (
			<div className="panel" style={styles}>
			  <button className="btn btn-primary generate" disabled={!titles}
			    onClick={() => this.props.generatePoster() }>Generate poster</button>
	
			  {panelContent}
			</div>
		);
	}
}