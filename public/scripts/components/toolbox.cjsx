React = require 'react'

class Toolbox extends React.Component
  render: ->
    styles = left: @props.left

    <div className="toolbox" style={styles}>
    </div>

module.exports = Toolbox
