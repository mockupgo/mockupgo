activate_note = (note) -> 
    note.draggable(
        stop: (event) -> update_note_pos $(this), event
    ).resizable(
        stop: (event) -> update_note_pos $(this), event
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

            offset = et.offset()
            scroll_from_top = parseInt(et.scrollTop())

            $('.note-new').css
                top:    parseInt(helper.css('top')) - parseInt(offset.top) + scroll_from_top
                left:   parseInt(helper.css('left')) - parseInt(offset.left)
                width:  helper.css('width')
                height: helper.css('height')

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
                $.ajax '/pages/aside'
                    type: 'GET'
                    dataType: 'HTML'
                    data: 
                        mockup: screenshot.data('mockup')
                    success: (data) -> 
                        $('aside').html(data)

    # Setup note deletion
    $(document).on 'click', 'a.delete-note', (event) ->
        event.preventDefault()
        $(this).parent().fadeOut()
        $.ajax '/annotations/' + $(this).parent().data('id'),
            type: 'DELETE'
            dataType: 'SCRIPT'


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
        new_comment = $(this).parent().find('textarea').val()
        note  = $(this).closest('div.note')
        update_note_comment(note, new_comment)


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
