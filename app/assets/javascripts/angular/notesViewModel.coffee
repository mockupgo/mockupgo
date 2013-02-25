NotesViewModel = ($scope) ->


    $scope.onUpdate = (note) ->
        $("div.note[data-id='" + note.id + "']").css 'top':note.top, 'left':note.left, 'width':note.width, 'height':note.height
        # note.find(".comment-text").html data.comment

    $scope.onDelete = (id) ->
        $("div.note[data-id='#{id}']").fadeOut(durations.fadeout).remove()

    $scope.onDeleteClick = (id) ->
        $scope.notes.delete id

    $scope.onCreate = (note) ->
        new_note = $ "div[data-id=#{note.oldId}]"
        console.log("received new note")
        screenshot = $ '.image-container'
        comment = screenshot.find('div.note-new textarea#comment').val()
        new_note.find('div.note-content').html '<div class="comment-text">' + comment + '</div>'
        new_note.removeClass('note-new').data 'id', note.id

    $scope.onUpdateAside = (data) ->
        $('aside').html(data)

    $scope.onAdd = ->
        $scope.notes.commitCreate $scope.newnote

###########---NEW ---------------------------------------

    $scope.onUpdateScrollPos = (data) ->
        window.current_scroll = data.pos
        $('.screenshot-portrait').scrollTop(data.pos)

###########---INTERACTIVITY----------------------------------

    window.server = new window.ServerService window.pusher, $scope
    $scope.notes = new Notes $scope, window.pusherService, window.server

    $ ->
        $(".delete-note").click ->
            $scope.onDeleteClick $(this).parent('.note').data('id')

(if window? then window else exports).NotesViewModel = NotesViewModel
