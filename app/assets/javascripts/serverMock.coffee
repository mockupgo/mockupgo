return if window?
class ServerMock
    constructor: (@pushers) ->
        @notes = {}

    create: (note) ->
        generateRealId: -> #emulate real id generation, not random in reality
            loop
                realId = Math.random() * 1000
                break unless @notes[realId]?
            realId

        note.oldId = note.id
        note.id = generateRealId()
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
