AppDispatcher = require '../dispatcher/app-dispatcher'
{EventEmitter} = require 'events'

class BaseStore extends EventEmitter
  addChangeListener: (callback) =>
    @on 'change', callback

  removeChangeListener: (callback) =>
    @removeListener BaseStore.CHANGE_EVENT, callback

BaseStore.CHANGE_EVENT = 'change'

module.exports = BaseStore