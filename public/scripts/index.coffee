goog.provide 'app'

goog.require 'goog.dom'
goog.require 'goog.dom.forms'
goog.require 'goog.style'
goog.require 'goog.graphics.CanvasGraphics'
goog.require 'goog.graphics.Font'
goog.require 'goog.graphics.Stroke'
goog.require 'goog.graphics.SolidFill'
goog.require 'goog.events'
goog.require 'goog.i18n.DateTimeSymbols_cs'
goog.require 'goog.i18n.DateTimePatterns_cs'
goog.require 'goog.ui.DatePicker'
goog.require 'goog.string'

width = 1227
height = 885
canvasElement = goog.dom.getElement 'posterCanvas'
fontForm = goog.dom.getElement 'dateLabelFont'

goog.style.setSize canvasElement, width, height

app.canvas = new goog.graphics.CanvasGraphics width, height
app.context = app.canvas.getContext()

app.canvas.render canvasElement
app.canvas.drawImage 0, 0, width, height, '../posters/krkanka_base.png'

font = new goog.graphics.Font 45, 'Times New Roman'

labelDate = app.canvas.drawText(
	'', 150, 180, 300, font.size, 'left', 'top', font,
	new goog.graphics.Stroke(2, 'red'), new goog.graphics.SolidFill('black')
)

# set czech localization
goog.i18n.DateTimeSymbols = goog.i18n.DateTimeSymbols_cs
goog.i18n.DateTimePatterns = goog.i18n.DateTimePatterns_cs

dateLabelInput = new goog.ui.DatePicker()
dateLabelInput.setShowWeekNum false
dateLabelInput.setShowToday false
dateLabelInput.setAllowNone false

pickerEvents = [
	goog.ui.DatePicker.Events.CHANGE
	goog.ui.DatePicker.Events.CHANGE_ACTIVE_MONTH
]

goog.events.listen dateLabelInput, pickerEvents, (ev) ->
	date = goog.string.padNumber(ev.date.getDate(), 2) + '.' +
		goog.string.padNumber(ev.date.getMonth() + 1, 2) + '. ' + ev.date.getYear()

	labelDate.setText date

goog.events.listen fontForm, goog.events.EventType.CHANGE, (ev) -> 
	values = goog.dom.forms.getFormDataMap(ev.currentTarget).toObject()

	goog.style.setStyle labelDate.getElement(), {
	 		fontSize: "#{values.size}pt"
	 		fontFamily: values.family
	 		fontStyle: if values.italic then 'italic' else 'normal'
	 		fontWeight: if values.bold then 'bold' else 'normal' 
	 }

dateLabelInput.render goog.dom.getElement 'dateLabelInput'