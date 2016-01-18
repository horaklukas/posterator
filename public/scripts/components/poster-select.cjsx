React = require 'react'
Grid = require('react-bootstrap/lib/Grid')
Row = require('react-bootstrap/lib/Row')
Col = require('react-bootstrap/lib/Col')
Thumbnail = require('react-bootstrap/lib/Thumbnail')
_map = require 'lodash.map'
{selectPoster} = require '../actions/poster-actions-creators'

class PosterText extends React.Component
  handlePosterSelect: (id) ->
    selectPoster id

  createThumbnail: ({name, url}, i) =>
    <Col md={4} key={"thumb-col-#{i}"}>
      <PosterThumbnail name={name} url={url} id={i} onSelect={@handlePosterSelect} />
    </Col>

  render: ->
    posterThumbnails = _map @props.posters, @createThumbnail

    <div className="poster-select">
      <Grid fluid>
        <Row>
          {posterThumbnails}
        </Row>
      </Grid>
    </div>

class PosterThumbnail extends React.Component
  handleClick: =>
    @props.onSelect @props.id

  render: ->
    <Thumbnail src={@props.url} onClick={@handleClick}>
      <h5>{@props.name}</h5>
    </Thumbnail>
module.exports = PosterText