(function() {
  var doc, jsdom,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  jsdom = require('jsdom').jsdom;
  global.mockery = require('mockery');

  doc = jsdom();
  global.window = doc.parentWindow;
  global.document = doc.parentWindow.document;
  global.navigator = doc.parentWindow.navigator;

  global.TestUtils = require('react/addons').addons.TestUtils;
  global.React = require('react');

  global.mockComponent = function(mockClassName) {
    var MockComponent;
    return MockComponent = (function(_super) {
      __extends(MockComponent, _super);

      function MockComponent() {
        return MockComponent.__super__.constructor.apply(this, arguments);
      }

      MockComponent.prototype.render = function() {
        var props;
        props = this.props;
        props.className = mockClassName;
        return React.createElement('div', props);
      };

      return MockComponent;

    })(React.Component);
  };

  mockery.enable({warnOnUnregistered: false});

}).call(this);
