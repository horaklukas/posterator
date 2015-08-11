AppDispatcher = require '../dispatcher/app-dispatcher'
constants = require '../constants/editor-constants'
WebFontLoader = require 'webfontloader'

fontsList = [
  'Arial'
  'Times New Roman'
  'Verdana'
  'Roboto'
  'Montserrat'
  'Arimo'
  'Droid Sans'
  'Ubuntu'
]

EditorUtils =
  loadFonts: ->
    EditorUtils.getFontsList (families) ->
      WebFontConfig =
        google: families: families
        #loading: -> console.log 'All fonts loading'
        active: ->
          AppDispatcher.dispatch {type: constants.FONTS_LOADED, fonts: families}
        #inactive: -> console.log 'All fonts inactive'
        #fontloading: (familyName, fvd) -> console.log 'Font', familyName, 'loading'
        #fontactive: (familyName, fvd) -> console.log 'Font', familyName, 'active'
        #fontinactive: (familyName, fvd) -> console.log 'Font', familyName, 'inactive'

      WebFontLoader.load(WebFontConfig)

  getFontsList: (cb) ->
    setTimeout ->
      cb fontsList
    , 1000

module.exports = EditorUtils