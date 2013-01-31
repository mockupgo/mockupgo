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

            @memberAddedHandlers[toHandle.trigger] = (w for w in mah when not w.oneOff)


    subscribe: (method, handler) ->
        @addHandler method, handler, no

    receive: (method, handler) ->
        @addHandler method, handler, yes
        handler()

    addHandler: (method, handler, oneOff) ->
        @memberAddedHandlers[method] = [] unless @memberAddedHandlers[method]?
        @memberAddedHandlers[method].push handler: handler, oneOff: oneOff

    when: (method, toTrigger) ->
        @toTrigger[method] = [] unless @toTrigger[method]?
        @toTrigger[method].push toTrigger

    smth: (val) ->
        yes

exports.PusherMock = PusherMock
