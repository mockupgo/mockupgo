class Notes
    constructor: (@viewModel, @pusher, @server) ->
        @data = {}
        @count = 0
        @init()

    init: =>
        @server.getNotes (data) =>
            @data = data

    get: (id) =>
        @data[id]

    subscribe: =>
        @pusher.subscribe "client-new-note-in-progress", (note) =>
            @push note

        @pusher.subscribe "create-note", (note) =>
            @pop note.oldId
            @push note

        @pusher.subscribe "update-note", (note) =>
            @push note

        @pusher.subscribe "client-delete-note-in-progress", (note) =>
            @pop note.id

    pop: (id) =>
        @count--
        delete @data[id]
        @viewModel.onDelete id

    push: (note) =>
        @count++ unless @data[note.id]?
        @data[note.id] = note
        @viewModel.onUpdate note

    create: (note) =>
        unless note.id?
            loop
                note.id = Math.random() * 1000
                break if @data[note.id]?
        @pusher.send "client-new-note-in-progress", note

    commitCreate: (note) =>
        @server.create note

    updateSize: (note) =>
        @push note
        @pusher.send "client-update-note-size", note

    updatePos: (note) =>
        @push note
        @pusher.send "client-update-note-position", note

    commitUpdate: (note) =>
        @server.update note

    delete: (note) =>
        @pop note.id
        @pusher.send "client-delete-note-in-progress", note
        @server.delete note

exports.Notes = Notes
