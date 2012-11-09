window.App = angular.module 'AnnotationApp', ['ngResource']


window.App.factory "AnnotationsService", ($resource) ->
  $resource "/image_versions/:image_version_id/annotations/:annotation_id"


window.App.directive 'annotable', () ->
    restrict: 'A'
    link: (scope, elm, attr) ->
        $(elm).selectable
            start: (event) ->
                # Only one new note should be active at one time
                $('div.note-new').remove()
            stop: (event, ui) ->
                et = $(event.target)
                et.find('.notes').append('<div class="note-new note draggable"><a href="#" class="delete-note">Delete</a><div class="note-comment"><span id="arrow"></span><div class="note-content"><div id="comment_bar" class="input_bar"><form method="post" action=""><div class="textarea"><textarea name="comment" id="comment" class="replace" rows="3"></textarea></div><button type="submit" class="black create-button">Add Note</button></form></div></div></div></div>')
                activate_note $('.note') # WHICH NOTES ?
                helper = $("div.ui-selectable-helper")
                note_width = parseInt(helper.css('width'))
                note_height = parseInt(helper.css('height'))

                if note_width < 4 and note_height < 4
                    return

                offset = et.offset()
                scroll_from_top = parseInt(et.scrollTop())

                $('.note-new').css
                    top:    parseInt(helper.css('top')) - parseInt(offset.top) + scroll_from_top
                    left:   parseInt(helper.css('left')) - parseInt(offset.left)
                    width:  note_width
                    height: note_height

                $('.note-new textarea#comment').focus()


window.App.directive 'note', () ->
    restrict:'E'
    replace: true
    template:   '<div>' +
                    '<span class="black note-counter ng-binding">' +
                        '6' +
                    '</span>' +
                    '<a class="delete-note" href="#" style="display: block;">Delete</a>' +
                    '<div class="note-wrapper">' +
                        '<div class="note-comment">' +
                            '<span id="arrow"></span>' +
                            '<div class="note-content">' +
                                '<div class="comment-text ng-binding">' +
                                    '{{note.comment}}' +
                                '</div>' +
                            '</div>' +
                        '</div>' +
                    '</div>' +
                '</div>'

    link: (scope, element, attr) ->
        element.addClass('note')
        element.draggable
                stop:  (event) -> 
                    alert("bla")
                    # update_note_pos $(this), event
            .resizable()

        scope.$watch attr.noteLeft, (left) ->
            element.css "left", left + "px"

        scope.$watch attr.noteTop, (top) ->
            element.css "top", top + "px"
        
        scope.$watch attr.noteWidth, (width) ->
            element.css "width", width + "px"

        scope.$watch attr.noteHeight, (height) ->
            element.css "height", height + "px"



window.App.controller 'annotationsCtrl',  ($scope, AnnotationsService) ->
    $scope.image_version_id = $('div[data-image-version]').attr("data-image-version")
    $scope.annotations = AnnotationsService.query({image_version_id: $scope.image_version_id})
