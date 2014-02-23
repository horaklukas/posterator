goog.provide 'app'

goog.require 'goog.dom'
goog.require 'este.react'
goog.require 'app.comps.Canvas'

appElement = goog.dom.getElement 'posteratorApp'

canvasProps =
	width: 1227
	height: 885
	url: '../posters/krkanka_base.png'

este.react.render app.comps.Canvas(canvasProps), appElement