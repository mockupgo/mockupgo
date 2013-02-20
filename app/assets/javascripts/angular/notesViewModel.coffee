NotesViewModel = ($scope) ->
    $scope.onUpdate = (note) ->
        $('#'+note.id).css 'top':note.top, 'left':note.left, 'width':note.width, 'height':note.height

    $scope.onDelete = (id) ->
        $('#'+id).fadeOut(durations.fadeout)

    $scope.onCreate = (note) ->
        new_note = $ 'div.note-new'
        console.log("received new note")
        comment = screenshot.find('div.note-new textarea#comment').val()
        new_note.find('div.note-content').html '<div class="comment-text">' + comment + '</div>'
        new_note.removeClass('note-new').attr 'data-id', data.id
        update_aside(screenshot.data('image-version'))

    $scope.onUpdateAside = (data) ->
        $('aside').html(data)

    $scope.notes = new Notes $scope, window.pusherService, window.server

(if window? then window else exports).NotesViewModel = NotesViewModel
