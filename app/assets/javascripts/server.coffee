class ServerService
    constructor: (@pusher, @notesViewModel)->

    getComments: (callback) ->
        comments = []
        $(".comment-text").each (i, c) =>
            comment = $ c
            id = comment.parents('.note').data 'id'
            comments.push text: comment.text(), id: id
        callback comments


    getNotes: (callback) ->
        notes = {}
        $('.note').each (i, n) =>
            note = $ n
            id = note.data 'id'
            notes[id] =
                id: id
                left: parseInt note.css('left')
                top: parseInt note.attr('top')
                width: parseInt note.attr('width')
                height: parseInt note.attr('height')
                comment: note.find('.comment-text').text()
        callback notes

    create: (note) =>
        image_version = $('.current-version div[data-image-version]').attr("data-image-version")
        $.ajax '/annotations',
            type: 'POST'
            dataType: 'JSON'
            data:
                socket_id: @pusher.connection.socket_id
                note_oldid: note.id
                image_version: image_version
                comment: note.comment
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


