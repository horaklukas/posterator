React = require 'react'
TitleEdit = require './titleEdit'

module.exports = React.createClass
	getDefaultProps: ->
		width: 800, height: 600, url: ''

	render: ->
		styles =
			width: @props.width
			height: @props.height
			backgroundImage: "url(#{@props.url})"

		<div style={styles}>
			<TitleEdit top={170} left={150} width={300} height={100} text={'Krkanka'} size={20} font={'Verdana'} />
			<TitleEdit top={400} left={160} width={400} height={65} text={''}
				size={10} font={'Verdana'} />
		</div>