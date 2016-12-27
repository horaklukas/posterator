//AppDispatcher = require '../dispatcher/app-dispatcher'
//constants = require '../constants/editor-constants'
import * as WebFontLoader from 'webfontloader';
//getJSON = require 'jquery-ajax-json'
import fontsList from 'json!../../data/fontsList.json';

export function loadFonts() {
  getFontsList(function(families) {
    let WebFontConfig = {
      google: {
        families: families
      },
      //loading: -> console.log 'All fonts loading'
      active: function() {}
        //AppDispatcher.dispatch({
          //type: constants.FONTS_LOADED, 
          //fonts: families
        //})
      //inactive: -> console.log 'All fonts inactive'
      //fontloading: (familyName, fvd) -> console.log 'Font', familyName, 'loading'
      //fontactive: (familyName, fvd) -> console.log 'Font', familyName, 'active'
      //fontinactive: (familyName, fvd) -> console.log 'Font', familyName, 'inactive'
    };

    WebFontLoader.load(WebFontConfig);
  });
}

function getFontsList(cb) {
  //getJSON('./fonts-list.json').then cb, (err) -> console.log 'Failed to load fonts'
  cb(fontsList.sort())
}

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