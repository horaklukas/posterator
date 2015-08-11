React = require 'react'
_map = require 'lodash.map'
{selectPoster} = require '../actions/poster-actions-creators'

class PosterText extends React.Component
  handlePosterSelect: (id) ->
    selectPoster id

  createThumbnail: ({name, url}, i) =>
    <Thumbnail name={name} url={url} id={i} key={i} onSelect={@handlePosterSelect} />

  render: ->
    PosterThumbnails = _map @props.posters, @createThumbnail

    <div className="poster-select">{PosterThumbnails}</div>

class Thumbnail extends React.Component
  handleClick: =>
    @props.onSelect @props.id

  render: ->
    <div className="thumbnail" onClick={@handleClick}>
      <strong>{@props.name}</strong>
      <img src={@props.url} />
    </div>

module.exports = PosterText