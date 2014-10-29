module.exports =
	titles: 
		changeFont: (id, property, value) ->
			@dispatch 'FONT_CHANGE', {id: id, prop: property, value: value}

		changeText: (id, text) ->
			@dispatch 'TEXT_CHANGE', {id: id, text: text}

		changePosition: (id, left, top) ->
			@dispatch 'POSITION_CHANGE', {id: id, x: left, y: top}			