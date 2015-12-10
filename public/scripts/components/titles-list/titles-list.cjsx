React = require 'react'
TitleSelector = require './title-selector'
_map = require 'lodash.map'
actions = require '../../actions/poster-actions-creators'

class TitlesList extends React.Component
  createTitleSelector: ({text}, index) =>
    <TitleSelector id={index} label={text} key={index} />

  render: ->
    <div className="titles-list">
      {_map @props.titles, @createTitleSelector}

      <button className="btn add" onClick={actions.addNewTitle}>
        Add new title
      </button>
    </div>

TitlesList.propTypes =
  titles: React.PropTypes.array

module.exports = TitlesList