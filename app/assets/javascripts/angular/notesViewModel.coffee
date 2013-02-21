NotesViewModel = ($scope) ->


    $scope.onUpdate = (note) ->
        $("div.note[data-id='" + note.id + "']").css 'top':note.top, 'left':note.left, 'width':note.width, 'height':note.height
        # note.find(".comment-text").html data.comment

    $scope.onDelete = (id) ->
        $("div.note[data-id='" + id + "']").fadeOut(durations.fadeout).remove()

    $scope.onCreate = (note) ->
        new_note = $ 'div.note-new'
        console.log("received new note")
        comment = screenshot.find('div.note-new textarea#comment').val()
        new_note.find('div.note-content').html '<div class="comment-text">' + comment + '</div>'
        new_note.removeClass('note-new').attr 'data-id', data.id
        update_aside(screenshot.data('image-version'))

    $scope.onUpdateAside = (data) ->
        $('aside').html(data)

###########---NEW ---------------------------------------

    $scope.onUpdateScrollPos = (data) ->
        window.current_scroll = data.pos
        $('.screenshot-portrait').scrollTop(data.pos)

###########---INTERACTIVITY----------------------------------



    $scope.notes = new Notes $scope, window.pusherService, window.server

(if window? then window else exports).NotesViewModel = NotesViewModel
