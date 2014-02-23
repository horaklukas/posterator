goog.provide 'app.comps.Canvas'

goog.require 'app.comps.TitleEdit'
goog.require 'este.react'

app.comps.Canvas = este.react.create (`/** */`)
	getDefaultProps: ->
		'width': 800, 'height': 600, 'url': ''

	render: ->
		styles =
			'width': @props['width']
			'height': @props['height']
			'backgroundImage': "url(#{@props['url']})"

		@div {'style': styles}, [
			app.comps.TitleEdit {
				'top': 170, 'left': 150, 'width': 300, 'height': 100, 'text': 'Krkanka'
			}, { 'size': 20 , 'font': 'Verdana'}
			app.comps.TitleEdit {
				'top': 400, 'left': 160, 'width': 400, 'height': 65, 'text': ''
			}, { 'size': 10 , 'font': 'Verdana'	}
		]