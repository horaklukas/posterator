# @cjsx React.DOM

React = require 'react'
Canvas = require './components/canvas'

React.renderComponent(
	<Canvas width={1227} height={885} url={'../posters/krkanka_base.png'} />
	document.getElementById 'posteratorApp'
)
