class Notes
    constructor: (@viewModel, @pusher, @server) ->
        @data = {}
        @count = 0
        @init()

    init: =>
        @server.getNotes (notes) =>
            _.forEach notes, (note) =>
                @push _.cloneDeep note

    get: (id) =>
        @data[id]

    subscribe: =>
        @pusher.subscribe "client-new-note-in-progress", (note) =>
            @push note

        @pusher.subscribe "create-note", (note) =>
            @pop note.oldId
            @push note

        # @pusher.subscribe "client-update-note-size", (note) =>
        #     @push note.id

        # @pusher.subscribe "client-update-note-position", (note) =>
        #     @push note.id

        @pusher.subscribe "update-note", (note) =>
            @push note

        @pusher.subscribe "client-delete-note-in-progress", (note) =>
            console.log note
            @pop note.id

    pop: (id) =>
        @count-- if @data[id]?
        delete @data[id]
        @viewModel.onDelete id

    push: (note) =>
        @count++ unless @data[note.id]?
        @data[note.id] = note
        @viewModel.onUpdate note

    create: (note) =>
        unless note.id?
            loop
                note.id = parseInt Math.random() * 1000
                break unless @data[note.id]?
        @push note
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

    delete: (id) =>
        @pusher.send "client-delete-note-in-progress", @data[id]
        @pop id
        @server.delete id

(if window? then window else exports).Notes = Notes
