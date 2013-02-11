class Notes
    constructor: (@viewModel, @pusher, @server) ->
        @data = {}
        @count = 0
        return unless window?
        @init()

    init: =>
        $('.note').each (i, n) =>
            @data[n.data('id')] = left: n.left(), top: n.top(), width: n.width(), height: n.height()

    subscribe: =>
        @pusher.subscribe "client-new-note-in-progress", (note) =>
            @push note

        @pusher.subscribe "create-note", (note) =>
            delete @data[note.oldId]
            @server.save note
            @push note

    push: (note) =>
        @count++ unless @data[note.id]?
        @data[note.id] = note
        @viewModel.onUpdate note

    add: (note) =>
        note.id = Math.random() * 1000
        while @data[note.id]
            note.id = Math.random() * 1000
        @pusher.send "client-new-note-in-progress", note

