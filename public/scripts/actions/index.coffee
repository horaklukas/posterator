module.exports =
	titles: 
		changeFont: (id, property, value) ->
			@dispatch 'FONT_CHANGE', {id: id, prop: property, value: value}

		changeText: (id, text) ->
			@dispatch 'TEXT_CHANGE', {id: id, text: text}