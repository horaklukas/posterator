import {createStructuredSelector} from 'reselect';
import {NAME} from './editorConstants';
import {selectedPoster, selectedPosterId} from 'features/posters';

const editor = (state) => state[NAME];

export const selector = createStructuredSelector({
  editor,
  poster: selectedPoster,
  selectedPosterId
});

/*
getAvailableFonts: ->
  this.fonts

isTitleDragged: (titleId) ->
  this.dragged.id is titleId

getDraggedTitleId: ->
  this.dragged.id

countTitlePosition: (actualClientX, actualClientY) ->
  x: (actualClientX - this.dragged.x) + this.dragged.initialPosition.x
  y: (actualClientY - this.dragged.y) + this.dragged.initialPosition.y

isTitleSelected: (id) ->
  this.selectedTitle is id

getSelectedTitleId: ->
  this.selectedTitle

getHoveredTitleId: ->
  this.hoveredTitle
*/