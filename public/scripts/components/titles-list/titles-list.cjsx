React = require 'react'
TitleSelector = require './title-selector'
_map = require 'lodash.map'

class TitlesList extends React.Component
  createTitleSelector: ({text}, id) =>
    <TitleSelector id={id} label={text} key={id} />

  render: ->
    <div className="titles-list">
      {_map @props.titles, @createTitleSelector}
    </div>

TitlesList.propTypes =
  titles: React.PropTypes.array

module.exports = TitlesList