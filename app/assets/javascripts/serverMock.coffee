class ServerMock
    constructor: ->
        @notes = {}

    create: (note) ->
        @notes[note.id] = note

    update: (note) ->
        @notes[note.id] = note

    delete: (note) ->
        delete @notes[note.id]

    getNotes: (callback) ->
        callback @notes

exports.ServerMock = ServerMock
