AppDispatcher = require '../dispatcher/app-dispatcher'
{EventEmitter} = require 'events'

class Store extends EventEmitter
  addChangeListener: (callback) =>
    @on 'change', callback

  removeChangeListener: (callback) =>
    @removeListener Store.CHANGE_EVENT, callback

Store.CHANGE_EVENT = 'change'

module.exports = Store