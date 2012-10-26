:javascript
  // Enable pusher logging - don't include this in production
  Pusher.log = function(message) {
    if (window.console && window.console.log) window.console.log(message);
  };

  // Flash fallback logging - don't include this in production
  WEB_SOCKET_DEBUG = true;

  var pusher = new Pusher('0f5ad327c0a36a8fe378');
  var channel = pusher.subscribe('my-channel');

  channel.bind('delete-note', function(data) {
    $("div.note[data-id='" + data.message + "']").fadeOut()
  });

  channel.bind('update-note', function(data) {
    note = $("div.note[data-id='" + data.id + "']")
    note.css( "top"    , data.top + "px"  )
    note.css( "left"   , data.left + "px"  )
    note.css( "width"  , data.width + "px"  )
    note.css( "height" , data.height + "px"  )
    note.find(".comment-text").text(data.comment)
  });

  channel.bind('update-note-position', function(data) { 
    note = $("div.note[data-id='" + data.id + "']")
    note.css( "top"    , data.top + "px"  )
    note.css( "left"   , data.left + "px"  )
  });

  channel.bind('create-note', function(data) {
    note = data.message

    $('.notes').append('<div class="note ui-selectee ui-draggable ui-resizable" data-id="' + note.id + '" style="top: ' + note.top + 'px; left: ' + note.left + 'px; width: ' + note.width + 'px; height: ' + note.height + 'px; position: absolute; "><span class="black note-counter ui-selectee"> x </span> <a class="delete-note ui-selectee" href="#" style="display: block; ">Delete</a> <div class="note-wrapper ui-selectee"> <div class="note-comment ui-selectee"> <span id="arrow" class="ui-selectee"></span> <div class="note-content ui-selectee"><div class="comment-text ui-selectee">' + note.comment + '</div></div></div></div><div class="ui-resizable-handle ui-resizable-e ui-selectee" style="z-index: 1000; "></div><div class="ui-resizable-handle ui-resizable-s ui-selectee" style="z-index: 1000; "></div><div class="ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se ui-selectee" style="z-index: 1000; "></div></div>')

  });