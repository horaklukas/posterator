import React, { Component, PropTypes } from 'react';
import classNames from 'classnames';
//import domEvents from 'dom-events';

//EditorStore = require '../stores/editor-store'
import * as CanvasUtils from '../utils/canvasUtils'
//actions = require '../actions/editor-actions-creators'
import BBox from '../utils/bbox'

export default class Canvas extends Component {
  static propTypes = {
    poster: PropTypes.shape({
      width: PropTypes.number, 
      height: PropTypes.number
    })
  };

  constructor(props) {
    super(props);
    
    this.state = {
      titlesBBoxes: []
    };
  }

  componentWillReceiveProps(nextProps) {
    this.redrawCanvas(nextProps.titles, nextProps.hoveredTitle);
  }

  redrawCanvas(titles, hoveredTitle) {
    let ctx = this.refs.canvas.getDOMNode().getContext('2d'),
      titlesBBoxes = [];

    ctx.drawImage(this.refs.image.getDOMNode(), 0, 0);

    titles.forEach(function(title, i) {
      let isHovered = hoveredTitle === i,
        width = CanvasUtils.drawTitleOnCanvas(ctx, title, i, isHovered),
        {x, y} = title.position;

      titlesBBoxes[i] = new BBox(x, y, width, title.font.size, title.angle);
    });

    this.setState({
      titlesBBoxes: titlesBBoxes
    });
  }

  handleMouseDown(e) {
    let {offsetX, offsetY} = e.nativeEvent,
      {titlesBBoxes} = this.state,
      titleId;

    for (id in titlesBBoxes) {
      let bbox = titlesBBoxes[id]; 

      if(bbox.contains(offsetX, offsetY)) {
        titleId = Number(id);
        break;
      }
    }

    if (titleId) {
      let {x, y} = this.props.titles[titleId].position;

      //actions.selectTitle(titleId);
      //actions.startTitleMove(titleId, e.clientX, e.clientY, x, y);

      //domEvents.on(document, 'mousemove', this.handleMove);
      //domEvents.on(document, 'mouseup', this.handleMouseUp);
      
    } else {
      // no title clicked, so unselect actual selected title
      //let selectedTitleId = EditorStore.getSelectedTitleId()
      
      //if(selectedTitleId) {
        //actions.unselectTitle(selectedTitleId);
      //}
      
    }
  }

  handleMove(e) {
    //if (!EditorStore.getDraggedTitleId()) {
      //e.preventDefault();
      //return;
    //}

    //actions.titleMove(e.clientX, e.clientY);
  }

  handleMouseUp(e) {
    //let selectedTitleId = EditorStore.getDraggedTitleId();

    //if (!selectedTitleId) {
      //return;
    //}

    //actions.stopTitleMove(selectedTitleId);

    //domEvents.off(document, 'mousemove', this.handleMove);
    //domEvents.off(document, 'mouseup', this.handleMouseUp);
  }

  handleImageLoad(ev) {
    this.redrawCanvas(this.props.titles, this.props.hoveredTitle);
  }

  render() {
    let {width, height, url} = this.props.poster,
      canvasClasses = classNames({
        'canvas': true,
        //'dragging-title': !!EditorStore.getDraggedTitleId()
      }); 
  
    return (
      <div className={canvasClasses}>
        <img src={url} ref="image" width={width} height={height}
          onLoad={this.handleImageLoad} />
        <canvas id="result-poster" ref="canvas" width={width} height={height}
          onClick={this.handleCanvasClick}
          onMouseDown={this.handleMouseDown}
          onMouseMove={this.handleMove}
          onMouseUp={this.handleMouseUp} >
        </canvas>
      </div>
    )
  }
}