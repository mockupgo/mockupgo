window.App = angular.module 'AnnotationApp', ['ngResource']


window.App.factory "AnnotationsService", ($resource) ->
  $resource "/image_versions/:image_version_id/annotations/:annotation_id"


window.App.factory "CurrentImageId", ($location) ->
  /\/image_versions\/([0-9]+)\/preview/.exec($location.absUrl())[1]


window.App.factory "AnnotationsManager", (AnnotationsService, CurrentImageId) ->
  data = null

  @notes = ->
      data = AnnotationsService.query({ image_version_id: CurrentImageId })

  @addNote = (note_comment, note_top, note_left, note_width, note_height) ->
    data.push
      id:       999
      comment:  note_comment
      top:      note_top
      left:     note_left
      width:    note_width
      height:   note_height
      isEdit:   true

  @



window.App.directive 'annotable', (AnnotationsManager) ->
  restrict: 'A'
  link: (scope, elm, attr) ->
    $(elm).selectable
      start: (event) ->
        # Only one new note should be active at one time
        $('div.note-new').remove()
      stop: (event, ui) ->
        et = $(event.target)

        # create new note
        # make it proper position and size
        # make it editable
        # add it to $scope.annotations in annotationsCtrl
        # remove .ui-selectable-helper

        # et.find('.notes').append('<div class="note-new note draggable"><a href="#" class="delete-note">Delete</a><div class="note-comment"><span id="arrow"></span><div class="note-content"><div id="comment_bar" class="input_bar"><form method="post" action=""><div class="textarea"><textarea name="comment" id="comment" class="replace" rows="3"></textarea></div><button type="submit" class="black create-button">Add Note</button></form></div></div></div></div>')
        # activate_note $('.note') # WHICH NOTES ?
        helper = $("div.ui-selectable-helper")
        offset = et.offset()
        scroll_from_top = parseInt(et.scrollTop())

        note_width  = parseInt(helper.css('width'))
        note_height = parseInt(helper.css('height'))
        note_top    = parseInt(helper.css('top'))  - parseInt(offset.top) + scroll_from_top
        note_left   = parseInt(helper.css('left')) - parseInt(offset.left)

        if note_width < 4 and note_height < 4
          return

        scope.$apply ->
          AnnotationsManager.addNote("---", note_top, note_left, note_width, note_height)

        $('.note-new textarea#comment').focus()


window.App.directive 'note', () ->
  restrict:'E'
  replace: true
  templateUrl: '/templates/annotation_template.html',
  link: (scope, element, attr) ->
    element.addClass('note')
    element.draggable
        stop:  (event) -> 
          # update_note_pos $(this), event
      .resizable()

    scope.note.isEdit = false

    scope.$watch attr.noteLeft, (left) ->
      element.css "left", left + "px"

    scope.$watch attr.noteTop, (top) ->
      element.css "top", top + "px"
    
    scope.$watch attr.noteWidth, (width) ->
      element.css "width", width + "px"

    scope.$watch attr.noteHeight, (height) ->
      element.css "height", height + "px"



window.App.controller 'annotationsCtrl',  ($scope, AnnotationsManager, CurrentImageId) ->
  $scope.image_version_id = $('div[data-image-version]').attr("data-image-version")
  $scope.annotations = AnnotationsManager.notes()



