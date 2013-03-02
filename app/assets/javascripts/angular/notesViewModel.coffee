NotesViewModel = ($scope, $compile) ->

    $scope.appendNote = (note) ->
        code = "<div class='note-new note draggable' data-id='#{note.id}'>
                    <a href='javascript:;' ng-click='onDeleteClick(#{note.id})' class='delete-note'>Delete</a>
                    <div class='note-comment'>
                        <span id='arrow'></span>
                        <div class='note-content'>
                            <div class='comment-text ui-selectee'>{{comments.get(note.id)}}</div>
                        </div>
                    </div>
                </div>"
        notesDiv = $ '.notes'
        notesDiv.append code
        $compile(notesDiv.contents()) $scope
        window.activate_note $scope.notes, $("div.note[data-id='#{note.id}']")

    $scope.onUpdate = (note) ->
        if $("div.note[data-id='#{note.id}']").length is 0
            canCreate = if $scope.newnote? then note.id isnt $scope.newnote.id else yes
            $scope.appendNote note if canCreate

        $scope.$apply =>
            $("div.note[data-id='#{note.id}']").css
                top:    note.top
                left:   note.left
                width:  note.width
                height: note.height
        #note.find(".comment-text").html $scope.coments.data[note.id].text

    $scope.onDelete = (id) ->
        $("div.note[data-id='#{id}']").fadeOut(durations.fadeout).remove()

    $scope.onDeleteClick = (id) ->
        wasReal = $scope.notes.get(id)?.oldId?
        $scope.notes.delete id
        $scope.notes.commitDelete id if wasReal

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
        $scope.newnote = null

###########---NEW ---------------------------------------

    $scope.onUpdateScrollPos = (data) ->
        window.current_scroll = data.pos
        $('.screenshot-portrait').scrollTop(data.pos)

###########---INTERACTIVITY----------------------------------


    $ ->
        window.server = new window.ServerService window.pusher, $scope
        $scope.notes = new Notes $scope, window.pusherService, window.server
        $scope.comments = new Comments $scope, window.pusherService, window.server, $scope.notes

        $(".delete-note").click ->
            $scope.onDeleteClick $(this).parent('.note').data('id')

(if window? then window else exports).NotesViewModel = NotesViewModel
