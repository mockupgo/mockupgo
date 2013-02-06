class PusherMock
    constructor: (@channel) ->
        @toTrigger = {}
        @memberAddedHandlers = {}

    send: (method, email) ->
        return unless @toTrigger[method]
        for toHandle in @toTrigger[method]
            mah = @memberAddedHandlers[toHandle.trigger]
            continue unless mah

            for wrapper in mah
                console.log "PusherMock: send: calling handler for #{toHandle.trigger}"
                wrapper.handler toHandle.args

    subscribe: (method, handler) ->
        @addHandler method, handler

    addHandler: (method, handler) ->
        @memberAddedHandlers[method] = [] unless @memberAddedHandlers[method]?
        @memberAddedHandlers[method].push handler: handler

    when: (method, toTrigger) ->
        @toTrigger[method] = [] unless @toTrigger[method]?
        @toTrigger[method].push toTrigger

exports.PusherMock = PusherMock
