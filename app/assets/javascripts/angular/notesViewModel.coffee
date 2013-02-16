NotesViewModel = ($scope) ->
    $scope.notes = new Notes @, pusher, server

    onUpdate: (note) ->
        $('#'+note.id).css 'top':note.top, 'left':note.left, 'width':note.width, 'height':note.height

    onDelete: (id) ->
        $('#'+id).fadeOut(durations.fadeout)


(if window? then window else exports).NotesViewModel = NotesViewModel
