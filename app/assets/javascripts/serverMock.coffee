return if window?
class ServerMock
    constructor: (@pushers) ->
        @notes = {}

    create: (note) ->
        generateRealId = => #emulate real id generation, not random in reality
            loop
                realId = parseInt Math.random() * 1000
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

    delete: (id) ->
        for pusher in @pushers
            pusher.send "delete-note", @notes[id]
        delete @notes[id]

    getNotes: (callback) ->
        callback @notes

    getComments: (callback) ->
        comments = []
        for n of @notes
            comments.push text:n.comment, id:n.id
        callback comments

exports.ServerMock = ServerMock
