//AppDispatcher = require '../dispatcher/app-dispatcher'
//constants = require '../constants/editor-constants'

function generatePoster() {
  let canvas = document.getElementById('result-poster'),
    data = canvas.toDataURL();

  let width = canvas.getAttribute('width'),
    height = canvas.getAttribute('height'),
    windowAttributes = `width=${width}, height=${height}`

  let posterWindow = window.open('', 'Result poster', windowAttributes);
  posterWindow.document.write(`<img src="${data}" width="100%" height="100%" />`)
  posterWindow.document.body.style.setProperty('margin', '0');
}