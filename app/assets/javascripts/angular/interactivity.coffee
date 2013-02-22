window.interval_timer = ''

window.start_realtime_update_for_create = (notes, note, event) ->
    console.log "start realtime update"
    # window.current_note = $("div.ui-selectable-helper")
    # window.console.log(window.current_note.css('width'))
    window.current_note_id = note.id
    userdata = $ '#userdata'
    window.current_user_id    = userdata.data 'current-user-id'
    window.current_user_email = userdata.data 'current-user-email'
    window.interval_timer = setInterval (note, id) ->
        helper = $ "div.ui-selectable-helper"
        et = $ ".ui-selectable"
        offset = et.offset()
        scroll_from_top = parseInt et.scrollTop()
        note_width  = parseInt helper.css 'width'
        note_height = parseInt helper.css 'height'
        note_top    = parseInt helper.css('top')  - parseInt(offset.top) + scroll_from_top
        note_left   = parseInt helper.css('left') - parseInt(offset.left)
        notes.create
            "id": window.current_note_id,
            "width":  note_width,
            "height": note_height,
            "top":  note_top,
            "left": note_left,
            "comment": "New note by " + window.current_user_email
    , 200

window.stop_realtime_update_for_create = (note, event) ->
    clearInterval window.interval_timer
    window.console.log "stop realtime update"

window.activate_note = (notes, note) ->
    window.console.log "activate_note"
    window.console.log note.length
    note.draggable
        start: (event) ->
            start_realtime_pos_update notes, $(this), event
        stop:  (event) ->
            stop_realtime_update notes, $(this), event

    note.resizable
        start: (event) ->
            start_realtime_size_update $(this), event
        stop: (event) ->
            stop_realtime_update notes, $(this), event

    note.bind
        mouseenter: ->
            $(this).find('a.delete-note').clearQueue().fadeIn(100)
        mouseleave: ->
            $(this).find('a.delete-note').clearQueue().fadeOut(100)

###########--for UPDATING===========================


start_realtime_pos_update = (notes, note, event) ->
    id = note.data 'id'
    window.console.log "start realtime update"
    window.current_note = note
    window.current_note_id = id
    window.interval_timer = setInterval (note, id) ->
        notes.updatePos
            "id":   window.current_note_id,
            "top":  window.current_note.css('top'),
            "left": window.current_note.css('left'),
            "width": window.current_note.css('width'),
            "height": window.current_note.css('height')
    , 200

start_realtime_size_update = (notes, note, event) ->
    id = note.data('id')
    window.console.log("start realtime update")
    window.current_note = note
    window.current_note_id = id
    window.interval_timer = setInterval (note, id) ->
        notes.updateSize
            "id":   window.current_note_id,
            "top":  window.current_note.css('top'),
            "left": window.current_note.css('left'),
            "width": window.current_note.css('width'),
            "height": window.current_note.css('height')
    , 200

stop_realtime_update = (notes, note, event) ->
    clearInterval(window.interval_timer)
    notes.commitUpdate note
    window.console.log("stop realtime update")
