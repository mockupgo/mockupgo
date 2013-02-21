start_realtime_update_for_create = (note, event) ->
    console.log "start realtime update"
    # window.current_note = $("div.ui-selectable-helper")
    # window.console.log(window.current_note.css('width'))
    window.current_note_id = note.id
    userdata = $ '#userdata'
    window.curent_user_id    = userdata.data 'current-user-id'
    window.curent_user_email = userdata.data 'current-user-email'
    interval_timer = setInterval (note, id) ->
        helper = $ "div.ui-selectable-helper"
        et = $ ".ui-selectable"
        offset = et.offset()
        scroll_from_top = parseInt et.scrollTop()
        note_width  = parseInt helper.css 'width'
        note_height = parseInt helper.css 'height'
        note_top    = parseInt helper.css('top')  - parseInt(offset.top) + scroll_from_top
        note_left   = parseInt helper.css('left') - parseInt(offset.left)
        window.channel_rt.trigger "client-new-note-in-progress",
            "id":   window.current_note_id,
            "width":  note_width,
            "height": note_height,
            "top":  note_top,
            "left": note_left,
            "comment": "New note by " + window.curent_user_email
    , 200

stop_realtime_update_for_create = (note, event) ->
    clearInterval interval_timer
    window.console.log "stop realtime update"

activate_note = (note) ->
    window.console.log "activate_note"
    window.console.log note.length
    note.draggable
        start: (event) ->
            start_realtime_pos_update $(this), event
        stop:  (event) ->
            stop_realtime_pos_update $(this), event
            update_note_pos $(this), event

    note.resizable
        start: (event) ->
            start_realtime_size_update $(this), event
        stop: (event) ->
            stop_realtime_size_update $(this), event
            update_note_pos $(this), event

    note.bind
        mouseenter: ->
            $(this).find('a.delete-note').clearQueue().fadeIn(100)
        mouseleave: ->
            $(this).find('a.delete-note').clearQueue().fadeOut(100)
