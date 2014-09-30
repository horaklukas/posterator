React = require 'react'
Fluxxor = require 'fluxxor'
FluxChildMixin = Fluxxor.FluxChildMixin React

module.exports = Canvas = React.createClass
	mixins: [FluxChildMixin]
	propTypes:
		width: React.PropTypes.number
		height: React.PropTypes.number
		url: React.PropTypes.string.isRequired

	render: ->
		styles =
			width: @props.width
			height: @props.height
			backgroundImage: "url(#{@props.url})"

		<div style={styles}></div>