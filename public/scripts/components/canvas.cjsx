React = require 'react'

class Canvas extends React.Component
  redrawCanvas: =>
    ctx = @refs.canvas.getDOMNode().getContext '2d'

    ctx.drawImage @refs.image.getDOMNode(), 0, 0

  render: ->
    {poster} = @props

    <div className="canvas">
      <img src={poster.url} ref="image" width={poster.width} height={poster.height} />
      <canvas ref="canvas"></canvas>
    </div>

module.exports = Canvas