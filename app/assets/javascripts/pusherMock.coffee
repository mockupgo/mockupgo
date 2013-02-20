return if window?
class PusherMock
    constructor: ->
        @subscriptions = {}

    send: (method, data) ->
        subscription = @subscriptions[method]
        return unless subscription?

        for handler in subscription.toHandle
            handler data

    subscribe: (method, handler) ->
        @subscriptions[method] = {} unless @subscriptions[method]?
        @subscriptions[method].toHandle = [] unless @subscriptions[method].toHandle?
        @subscriptions[method].toHandle.push handler


exports.PusherMock = PusherMock
