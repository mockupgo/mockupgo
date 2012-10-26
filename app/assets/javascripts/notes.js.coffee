$ ->
    Pusher.log = (message) ->
      window.console.log message  if window.console and window.console.log

    WEB_SOCKET_DEBUG = true
    pusher = new Pusher("0f5ad327c0a36a8fe378")
    channel   = pusher.subscribe("my-channel")
    channel_rt = pusher.subscribe("private-rt-update")
    window.channel_rt = channel_rt


    channel.bind "alert-note", (data) ->
        alert(data)


    channel.bind "delete-note", (data) ->
        $("div.note[data-id='" + data.message + "']").fadeOut()


    channel.bind "update-note", (data) ->
        note = $("div.note[data-id='" + data.id + "']")
        note.css "top", data.top + "px"
        note.css "left", data.left + "px"
        note.css "width", data.width + "px"
        note.css "height", data.height + "px"
        note.find(".comment-text").text data.comment


    channel_rt.bind "client-update-note-position", (data) ->
        note = $("div.note[data-id='" + data.id + "']")
        note.css "top", data.top
        note.css "left", data.left


    channel_rt.bind "client-update-note-size", (data) ->
        note = $("div.note[data-id='" + data.id + "']")
        note.css "width", data.width
        note.css "height", data.height


    channel_rt.bind "create-note", (data) ->
        note = data.message
        $(".notes").append "<div class=\"note ui-selectee ui-draggable ui-resizable\" data-id=\"" + note.id + "\" style=\"top: " + note.top + "px; left: " + note.left + "px; width: " + note.width + "px; height: " + note.height + "px; position: absolute; \"><span class=\"black note-counter ui-selectee\"> x </span> <a class=\"delete-note ui-selectee\" href=\"#\" style=\"display: block; \">Delete</a> <div class=\"note-wrapper ui-selectee\"> <div class=\"note-comment ui-selectee\"> <span id=\"arrow\" class=\"ui-selectee\"></span> <div class=\"note-content ui-selectee\"><div class=\"comment-text ui-selectee\">" + note.comment + "</div></div></div></div><div class=\"ui-resizable-handle ui-resizable-e ui-selectee\" style=\"z-index: 1000; \"></div><div class=\"ui-resizable-handle ui-resizable-s ui-selectee\" style=\"z-index: 1000; \"></div><div class=\"ui-resizable-handle ui-resizable-se ui-icon ui-icon-gripsmall-diagonal-se ui-selectee\" style=\"z-index: 1000; \"></div></div>"


activate_note = (note) -> 
    note.draggable(
        start: (event) -> 
            start_realtime_pos_update $(this), event
        stop:  (event) -> 
            stop_realtime_pos_update $(this), event
            update_note_pos $(this), event
    ).resizable(
        start: (event) -> 
            start_realtime_size_update $(this), event
        stop: (event) -> 
            stop_realtime_size_update $(this), event
            update_note_pos $(this), event
    ).bind
        mouseenter: -> 
            $(this).find('a.delete-note').clearQueue().fadeIn(100)
        mouseleave: -> 
            $(this).find('a.delete-note').clearQueue().fadeOut(100)

update_note_pos = (note, event) ->
    id = note.data('id')
    $.ajax '/annotations/' + id,
        type: 'PUT'
        dataType: 'JSON'
        data: 
            position:
                top:    note.css('top')
                left:   note.css('left')
                width:  note.css('width')
                height: note.css('height')

interval_timer = ''

start_realtime_pos_update = (note, event) ->
    id = note.data('id')
    window.console.log("start realtime update")
    window.current_note = note
    window.current_note_id = id
    interval_timer = setInterval((note, id) ->
            window.channel_rt.trigger "client-update-note-position", 
                "id":   window.current_note_id,
                "top":  window.current_note.css('top'),
                "left": window.current_note.css('left'),
        , 200)

stop_realtime_pos_update = (note, event) ->
    clearInterval(interval_timer)
    window.console.log("stop realtime update")
    


start_realtime_size_update = (note, event) ->
    id = note.data('id')
    window.console.log("start realtime update")
    window.current_note = note
    window.current_note_id = id
    interval_timer = setInterval((note, id) ->
            window.channel_rt.trigger "client-update-note-size", 
                "id":   window.current_note_id,
                "width":  window.current_note.css('width'),
                "height": window.current_note.css('height'),
        , 200)

stop_realtime_size_update = (note, event) ->
    clearInterval(interval_timer)
    window.console.log("stop realtime update")
    




update_note_comment = (note, comment) ->
    id = note.data('id')
    $.ajax '/annotations/' + id,
        type: 'PUT'
        dataType: 'JSON'
        data: 
            comment: comment
        success: (data) -> 
            note.find('div.note-content').html('<div class="comment-text">' + comment + '</div>')
            $('.note-new').removeClass('note-new')

update_aside = (image_version) ->
    $.ajax '/image_versions/' + image_version + '/aside'
        type: 'GET'
        dataType: 'HTML'
        success: (data) -> 
            $('aside').html(data)

jQuery ->
    $(".selectable").selectable
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


    # Get ready to receive note creation button events
    $(document).on 'click', 'div.note-comment button.create-button', (event) ->
        event.preventDefault()

        screenshot = $(event.target).closest('.image-container')
        comment = screenshot.find('div.note-new textarea#comment').val()
        helper  = screenshot.find('div.note-new')

        $.ajax '/annotations',
            type: 'POST'
            dataType: 'JSON'
            data: 
                image_version: screenshot.data('image-version')
                comment: comment
                position:
                    top:    helper.css('top')
                    left:   helper.css('left')
                    width:  helper.css('width')
                    height: helper.css('height')
            success: (data) -> 
                new_note = $('div.note-new')
                new_note.find('div.note-content').html('<div class="comment-text">' + comment + '</div>')
                new_note.removeClass('note-new').attr('data-id', data.id)
                update_aside(screenshot.data('image-version'))

    # Setup note deletion
    $(document).on 'click', 'a.delete-note', (event) ->
        event.preventDefault()
        screenshot = $(event.target).closest('.image-container')
        $(this).parent().fadeOut()
        $.ajax '/annotations/' + $(this).parent().data('id'),
            type: 'DELETE'
            dataType: 'SCRIPT'
        update_aside(screenshot.data('image-version'))


    # Setup note edition
    $(document).on 'click', 'div.comment-text', (event) ->
        event.preventDefault()
        current_note = $(this).text()
        note_field = $(this).closest('div.note-content')
                            .html('<div id="comment_bar" class="input_bar"><form method="post" action=""><div class="textarea"><textarea name="comment" id="comment" class="replace" rows="3"></textarea></div><button type="submit" class="black update-button">Update</button></form></div>').find('textarea')
        note_field.val(current_note)


    # Setup note save action
    $(document).on 'click', 'button.update-button', (event) ->
        event.preventDefault()
        screenshot = $(event.target).closest('.image-container')
        new_comment = $(this).parent().find('textarea').val()
        note  = $(this).closest('div.note')
        update_note_comment(note, new_comment)
        update_aside(screenshot.data('image-version'))


    # Loading existing notes 
    # TODO: NEED TO LOAD PORTRAIT AND LANDSCAPE NOTES FOR IPHONE AND IPAD
    # $.ajax '/notes'
    #   type: 'GET'
    #   dataType: 'HTML'
    #   data: 
    #       mockup: $('#page-content').data('mockup') ####
    #   success: (data) -> 
    #       $('#notes').html(data) ####
    activate_note $('.note')
    $('a.delete-note').hide()
