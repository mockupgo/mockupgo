class ServerMock
    constructor: ->
        @notes = {}

    save: (note) ->
        @notes[note.id] = note

