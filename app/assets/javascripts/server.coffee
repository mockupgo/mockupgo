class ServerService
    constructor: (@pusher)->

    getNotes: (callback) ->
        @notes = {}
        $('.note').each (i, n) =>
            id = n.data 'id'
            @notes[id] = id: id, left: n.left(), top: n.top(), width: n.width(), height: n.height()
        callback @notes

(if window? then window else exports).ServerService = ServerService


