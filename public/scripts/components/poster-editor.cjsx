React = require 'react'
TitlesList = require './titles-list/titles-list'
Toolbox = require './toolbox/toolbox'
Canvas = require './canvas'
actions = require '../actions/editor-actions-creators'

class Editor extends React.Component
  handleGenerate: ->
    actions.generatePoster()

  createToolbox: (title, leftPosition, fonts) ->
    <Toolbox left={leftPosition} text={title.text} font={title.font}
      titleAngle={title.angle} fonts={fonts} />

  render: ->
    {poster, titles, selectedTitle, fonts} = @props
    styles = left: poster.width
    titleToEdit = titles?[selectedTitle] ? null

    panelContent =
      if titleToEdit? then @createToolbox titleToEdit, poster.width, fonts
      else if titles? then <TitlesList titles={titles} />
      else null

    generateEnabled = titles?

    <div className="editor" style={height: poster.height} >
      <Canvas poster={poster} titles={titles} />

      <div className="panel" style={styles}>
        <button className="btn btn-primary generate" disabled={!generateEnabled}
          onClick={@handleGenerate}>Generate poster</button>

        {panelContent}
      </div>
    </div>

module.exports = Editor
