class ServerService
    constructor: (@pusher, @notesViewModel)->

    getComments: asdasdsgf #need to implement

    getNotes: (callback) ->
        notes = {}
        $('.note').each (i, n) =>
            note = $ n
            id = note.data 'id'
            notes[id] = id: id, left: note.attr('left'), top: note.attr('top'), width: note.attr('width'), height: note.attr('height')
        callback notes

    create: (note) =>
        image_version = $('.current-version div[data-image-version]').attr("data-image-version")
        $.ajax '/annotations',
            type: 'POST'
            dataType: 'JSON'
            data:
                socket_id: @pusher.connection.socket_id
                image_version: image_version
                comment: ''#comment
                position:
                    top:    note.top
                    left:   note.left
                    width:  note.width
                    height: note.height
            success: (data) =>
                @notesViewModel.onCreate data
                @update_aside image_version

    update: (note) =>
        $.ajax "/annotations/#{note.id}",
            type: 'PUT'
            dataType: 'JSON'
            data:
                position:
                    top:    note.top
                    left:   note.left
                    width:  note.width
                    height: note.height

    delete: (id) =>
        $.ajax "/annotations/#{id}",
            type: 'DELETE'
            dataType: 'SCRIPT'

    update_aside: (image_version) ->
        $.ajax "/image_versions/#{image_version}/aside",
            type: 'GET'
            dataType: 'HTML'
            success: @notesViewModel.onUpdateAside

(if window? then window else exports).ServerService = ServerService


