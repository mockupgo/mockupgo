window.module.directive 'showNotifications', ->
    (scope, element, attrs) ->
        scope.$watch 'notifications', (value) ->
            angular.forEach value, (notification, index) ->
                return if $(".flash-message-box ##{index}").length

                id = notification.id
                email = notification.email
                bLogIn = notification.bLogIn

                container = $ "<div>", class:"flash-message", style: "display:none", id: "presence_" + id

                message =  if id is scope.userNotifications.me.id then "You (#{email})" else "#{email} has"
                message += if bLogIn then " logged" else " exited"

                code = "<i class='icon-user icon-white' id='#{index}'></i> #{message}"

                html = container.html(code)
                                .fadeIn(window.durations.fadein)
                                .delay(window.durations.delay)
                                .fadeOut(window.durations.fadeout, ->
                                    $(".flash-message-box ##{index}").parent().remove())

                $('.flash-message-box').append html

                delete scope.notifications[index]
        , true

window.module.config ($compileProvider) ->
    $compileProvider.directive 'noteCreationTriggers', ($compile, $rootScope) ->
        (scope, element, attrs) ->
            $(element).selectable
                start: (event) ->
                    return if $(event.toElement).hasClass "delete-note"
                    if scope.newnote?
                        scope.notes.delete scope.newnote.id
                    scope.newnote = width:0, height:0, top:event.clientY, left:event.clientX, comment:""
                    scope.notes.create scope.newnote
                    $('div.note-new').remove()
                    $rootScope.interactivity.start_realtime_update_for_create scope.notes, scope.newnote, event
                stop: (event) ->
                    return if $(event.toElement).hasClass "delete-note"
                    $rootScope.interactivity.stop_realtime_update_for_create scope.newnote, event
                    et = $(event.target)
                    code = "<div class='note-new note draggable' data-id='#{scope.newnote.id}'>
                                <a href='javascript:;' ng-click='onDeleteClick(#{scope.newnote.id})' class='delete-note'>Delete</a>
                                <div class='note-comment'>
                                    <span id='arrow'></span>
                                    <div class='note-content'>
                                        <div id='comment_bar' class='input_bar'>
                                            <form method='post' action=''>
                                                <div class='textarea'>
                                                    <textarea name='comment' ng-model='newnote.comment' id='comment' class='replace' rows='3'></textarea>
                                                </div>
                                                <button type='submit' ng-click='onAdd()' class='black create-button'>
                                                    Add Note
                                                </button>
                                            </form>
                                        </div>
                                    </div>
                                </div>
                            </div>"
                    notesDiv = $ '.notes'
                    notesDiv.append code
                    $compile(notesDiv.contents()) scope
                    $rootScope.interactivity.activate_note scope.notes, $('.note-new') # WHICH NOTES ?
                    helper = $("div.ui-selectable-helper")
                    offset = et.offset()
                    scroll_from_top = parseInt(et.scrollTop())
                    note_width  = parseInt(helper.css('width'))
                    note_height = parseInt(helper.css('height'))
                    note_top    = parseInt(helper.css('top')) - parseInt(offset.top) + scroll_from_top
                    note_left   = parseInt(helper.css('left')) - parseInt(offset.left)

                    if note_width < 4 and note_height < 4
                        return

                    $('.note-new').css
                        top:    note_top
                        left:   note_left
                        width:  note_width
                        height: note_height
