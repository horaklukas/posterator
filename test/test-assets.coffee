{jsdom} = require 'jsdom'
global.mockery = require 'mockery'
chai = require 'chai'
sinonChai = require 'sinon-chai'
global.sinon = require 'sinon'
global.expect = chai.expect
chai.should()
chai.use sinonChai

doc = jsdom()
global.window = doc.parentWindow
global.document = doc.parentWindow.document
global.navigator = doc.parentWindow.navigator

global.TestUtils = require('react/addons').addons.TestUtils

global.React = require 'react'
global.mockComponent = (mockClassName) ->
  class MockComponent extends React.Component
    render: ->
      props = @props
      props.className = mockClassName

      React.createElement('div', props)

mockery.enable warnOnUnregistered: false