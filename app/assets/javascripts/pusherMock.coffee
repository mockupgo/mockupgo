class PusherMock
    @toTrigger: {}
    @memberAddedHandlers: {}

    constructor: (@channel) ->

    send: (method) ->
        return unless PusherMock.toTrigger[method]
        for toHandle in PusherMock.toTrigger[method]
            mah = PusherMock.memberAddedHandlers[toHandle.trigger]
            continue unless mah

            for handler in mah
                console.log "PusherMock: send: calling handler for #{toHandle.trigger}"
                handler toHandle.args

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
        PusherMock.toTrigger[method] = [] unless PusherMock.toTrigger[method]?
        PusherMock.toTrigger[method].push toHandle

exports.PusherMock = PusherMock
