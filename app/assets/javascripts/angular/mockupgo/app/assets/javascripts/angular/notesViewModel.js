//@ sourceMappingURL=mockupgo\app\assets\javascripts\angular\mockupgo\app\assets\javascripts\angular\notesViewModel.map
// Generated by CoffeeScript 1.6.1
(function() {
  var NotesViewModel;

  NotesViewModel = function($scope, $rootScope, $compile) {
    $scope.newnote = {};
    $scope.$watch('newnote.comment', function(value) {
      var _ref;
      if (((_ref = $scope.newnote) != null ? _ref.comment : void 0) == null) {
        return;
      }
      $scope.notes.get($scope.newnote.id).comment = value;
      return $scope.comments.create({
        id: $scope.newnote.id,
        text: value
      });
    });
    $scope.appendNote = function(note) {
      var code, notesDiv;
      code = "<div class='note-new note draggable' data-id='" + note.id + "'>                    <a href='javascript:;' ng-click='onDeleteClick(" + note.id + ")' class='delete-note'>Delete</a>                    <div class='note-comment'>                        <span id='arrow'></span>                        <div class='note-content'>                            <div class='comment-text ui-selectee'>" + note.comment + "</div>                        </div>                    </div>                </div>";
      code = $(code);
      notesDiv = $('.notes');
      notesDiv.append(code);
      $compile(notesDiv.contents())($scope);
      return $rootScope.interactivity.activate_note($scope.notes, code);
    };
    $scope.getComment = function(id) {
      var _ref;
      return (_ref = $scope.comments.get(id)) != null ? _ref.text : void 0;
    };
    $scope.onUpdateComment = function(comment) {
      if ($scope.newnote.comment === comment.text) {
        return;
      }
      return $("div.note[data-id=" + comment.id + "] .note-comment").text(comment.text);
    };
    $scope.onUpdate = function(note) {
      var canCreate;
      if ($("div.note[data-id='" + note.id + "']").length === 0) {
        canCreate = $scope.newnote != null ? note.id !== $scope.newnote.id : true;
        if (canCreate) {
          $scope.appendNote(note);
        }
      }
      return $("div.note[data-id='" + note.id + "']").css({
        top: note.top,
        left: note.left,
        width: note.width,
        height: note.height
      });
    };
    $scope.onDelete = function(id) {
      $("div.note[data-id='" + id + "']").fadeOut(durations.fadeout).remove();
      return $scope.comments.pop(id);
    };
    $scope.onDeleteClick = function(id) {
      var wasReal, _ref;
      wasReal = ((_ref = $scope.notes.get(id)) != null ? _ref.oldId : void 0) != null;
      $scope.notes["delete"](id);
      if (wasReal) {
        return $scope.notes.commitDelete(id);
      }
    };
    $scope.onCreate = function(note) {
      var new_note;
      new_note = $("div[data-id=" + note.oldId + "]");
      return new_note.find('div.note-content').html("<div class='comment-text'>" + note.comment + " + '</div>");
    };
    $scope.onUpdateAside = function(data) {
      return $('aside').html(data);
    };
    $scope.onAdd = function() {
      $scope.comments.commitCreate($scope.newnote.id);
      $('.note-new').removeClass('note-new').find('.note-content').html("<div class='comment-text'>" + $scope.newnote.comment + "</div>");
      return $scope.newnote = {};
    };
    $scope.onUpdateScrollPos = function(data) {
      return $('.screenshot-portrait').scrollTop(data.pos);
    };
    return $(function() {
      window.server = new window.ServerService(window.pusher, $scope);
      $scope.notes = new Notes($scope, window.pusherService, window.server);
      $scope.comments = new Comments($scope, window.pusherService, window.server, $scope.notes);
      $("div.note").each(function() {
        return $rootScope.interactivity.activate_note($scope.notes, $(this));
      });
      return $(".delete-note").click(function() {
        return $scope.onDeleteClick($(this).parent('.note').data('id'));
      });
    });
  };

  (typeof window !== "undefined" && window !== null ? window : exports).NotesViewModel = NotesViewModel;

}).call(this);
