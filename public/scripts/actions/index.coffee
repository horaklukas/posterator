module.exports = 
	changeTitleFont: (titleId, property, value) ->
		@dispatch 'FONT_CHANGE', {id: titleId, prop: property, value: value}