class PusherMock
    @subscriptions: {
        # "client-update-note-size": {
        #     toHandle: [{handler: func(), args: {...}}, ...]
        #     concomitants: ["update-note"]
        # }
    }
    # @memberAddedHandlers: {}

    constructor: (@channel, @id) ->

    send: (method, data) ->
        return unless PusherMock.subscriptions[method]
        for subscription in PusherMock.subscriptions[method]
            for concomitant in subscription.concomitants
                @send concomitant, data

            continue unless subscription.toHandle.length

            for handler in subscription.toHandle
                args = if data? then data else toHandle.args
                handler args

    subscribe: (method, handler) ->
        @addHandler method, handler
        if method in ["subscription_succeeded"]
            @send method
            index = PusherMock.memberAddedHandlers[method].indexOf handler
            PusherMock.memberAddedHandlers[method].splice index, 1

    addHandler: (method, handler) ->
        PusherMock.memberAddedHandlers[method] = [] unless PusherMock.memberAddedHandlers[method]?
        PusherMock.memberAddedHandlers[method].push handler

    when: (method, toHandle) ->
        PusherMock.subscriptions[method] = [] unless PusherMock.subscriptions[method]?
        PusherMock.subscriptions[method].push toHandle

exports.PusherMock = PusherMock
