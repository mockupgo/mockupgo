class ServerMock
    constructor: (@pushers) ->
        @notes = {}

    generateRealId: -> #emulate real id generation, not random in reality
        realId
        loop
            realId = Math.random() * 1000
            break unless @notes[realId]?
        realId

    create: (note) ->
        note.oldId = note.id
        note.id = @generateRealId()
        @notes[note.id] = note
        for pusher in @pushers
            pusher.send "create-note", note

    update: (note) ->
        @notes[note.id] = note
        for pusher in @pushers
            pusher.send "update-note", note

    delete: (note) ->
        delete @notes[note.id]
        for pusher in @pushers
            pusher.send "update-note", note

    getNotes: (callback) ->
        callback @notes

exports.ServerMock = ServerMock
