React = require 'react'
TitleSelector = require './title-selector'
_map = require 'lodash.map'
actions = require '../../actions/poster-actions-creators'

class TitlesList extends React.Component
  createTitleSelector: ({text}, index) =>
    <TitleSelector id={index} label={text} key={index} />

  createEmptyListMessage: ->
    <p className="alert alert-info">
      <span className="glyphicon glyphicon-info-sign"></span>
      There are no existing titles for poster
    </p>

  render: ->
    titles =
      if @props.titles.length > 0 then _map(@props.titles, @createTitleSelector)
      else @createEmptyListMessage()

    <div className="titles-list">
      {titles}

      <button className="btn add" onClick={actions.addNewTitle}>
        Add new title
      </button>
    </div>

TitlesList.propTypes =
  titles: React.PropTypes.array

module.exports = TitlesList