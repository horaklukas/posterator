# @cjsx React.DOM

React = require 'react'
Fluxxor = require 'fluxxor'
App = require './components/app'
actions = require './actions'
TitlesStore = require './stores/titles-store'
PostersStore = require './stores/posters-store'

stores =
	TitlesStore: new TitlesStore [
		{y: 170, x:150, w: 300, h: 100, text: 'Krkanka', size:20, font:'Verdana'}
		{y: 400, x:160, w: 400, h: 65, text: 'Datum', size: 10, font:'Verdana'}
	]
	PostersStore: new PostersStore [
		{w: 1227, h: 885, url: '../posters/krkanka_base.png'}
	],

flux = new Fluxxor.Flux stores, actions

React.renderComponent(
	<App flux={flux} />
	document.getElementById 'posteratorApp'
)
