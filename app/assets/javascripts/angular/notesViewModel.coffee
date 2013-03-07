NotesViewModel = ($scope, $rootScope, $compile) ->

    $scope.newnote = {}

    $scope.$watch 'newnote.comment', (value) ->
        return unless $scope.newnote?.comment?
        $scope.notes.get($scope.newnote.id).comment = value
        $scope.comments.create
            id: $scope.newnote.id
            text: value

    $scope.appendNote = (note) ->
        code = "<div class='note-new note draggable' data-id='#{note.id}'>
                    <a href='javascript:;' ng-click='onDeleteClick(#{note.id})' class='delete-note'>Delete</a>
                    <div class='note-comment'>
                        #{note.comment}
                        <div class='note-content'>
                            <div class='comment-text ui-selectee'></div>
                        </div>
                    </div>
                </div>"
        code = $ code
        notesDiv = $ '.notes'
        notesDiv.append code
        $compile(notesDiv.contents()) $scope
        $rootScope.interactivity.activate_note $scope.notes, code

    $scope.getComment = (id) ->
        $scope.comments.get(id)?.text

    $scope.onUpdateComment = (comment) ->
        return if $scope.newnote.comment is comment.text
        $("div.note[data-id=#{comment.id}] .note-comment").text comment.text

    $scope.onUpdate = (note) ->
        if $("div.note[data-id='#{note.id}']").length is 0
            canCreate = if $scope.newnote? then note.id isnt $scope.newnote.id else yes
            $scope.appendNote note if canCreate

        $("div.note[data-id='#{note.id}']").css
            top:    note.top
            left:   note.left
            width:  note.width
            height: note.height

    $scope.onDelete = (id) ->
        $("div.note[data-id='#{id}']").fadeOut(durations.fadeout).remove()
        $scope.comments.pop id

    $scope.onDeleteClick = (id) ->
        wasReal = $scope.notes.get(id)?.oldid?
        $scope.notes.delete id
        $scope.notes.commitDelete id if wasReal

    $scope.onCreate = (note) ->
        new_note = $ "div[data-id=#{note.oldid}]"
        new_note.find('div.note-content').html "<div class='comment-text'>#{note.comment} + '</div>"

    $scope.onUpdateAside = (data) ->
        $('aside').html data

    $scope.onAdd = ->
        $scope.comments.commitCreate $scope.newnote.id
        $('.note-new').removeClass('note-new').find('.note-content').html "<div class='comment-text'>#{$scope.newnote.comment}</div>"
        $scope.newnote = {}

    $scope.onUpdateScrollPos = (data) ->
        $('.screenshot-portrait').scrollTop data.pos

    $ ->
        window.server = new window.ServerService window.pusher, $scope
        $scope.notes = new Notes $scope, window.pusherService, window.server
        $scope.comments = new Comments $scope, window.pusherService, window.server, $scope.notes
        $("div.note").each ->
            $rootScope.interactivity.activate_note $scope.notes, $ @

        $(".delete-note").click ->
            $scope.onDeleteClick $(this).parent('.note').data 'id'

(if window? then window else exports).NotesViewModel = NotesViewModel
