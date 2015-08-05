AppDispatcher = require '../dispatcher/app-dispatcher'
constants = require '../constants/poster-constants'

POSTERS_PATH = '../posters'

posters = [
  {
    url: "#{POSTERS_PATH}/krkanka_base.png", name: 'Expedice Krkaňka',
    width: 1227, height: 885
  }
  {
    url: "#{POSTERS_PATH}/krkanka_base.png", name: 'Expedice Krkaňka 2',
    width: 1024, height: 768
  }
  {
    url: "#{POSTERS_PATH}/krkanka_base.png", name: 'Expedice Krkaňka 3',
    width: 1024, height: 768
  }
]

titles = {
  0: [
    {position:{x: 150, y: 170}, angle: 0, text: 'Krkanka', font: {size: 20, family: 'Verdana', color: '000', italic: false, bold: false}}
    {position:{x: 160, y: 400}, angle: 0, text: 'termin', font: {size: 16, family: 'Arial', color: '000', italic: false, bold: false}}
  ]
}

PosterUtils =
  loadPosters: ->
    setTimeout ->
      AppDispatcher.dispatch {type: constants.POSTERS_LOADED, posters: posters}
    , 500

  loadPosterTitles: (posterId) ->
    setTimeout ->
      AppDispatcher.dispatch {
        type: constants.TITLES_LOADED, titles: titles[posterId]
      }
    , 1000

module.exports = PosterUtils