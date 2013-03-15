class Interactivity

    start_realtime_update_for_create: (notes, comments, note, event) =>
        @interval_timer = setInterval ->
            helper = $ "div.ui-selectable-helper"
            et = $ ".ui-selectable"
            offset = et.offset()
            note.width  = parseInt(helper.css('width'))
            note.height = parseInt(helper.css('height'))
            note.top    = parseInt(helper.css('top'))  - parseInt(offset.top) + parseInt et.scrollTop()
            note.left   = parseInt(helper.css('left')) - parseInt(offset.left)
            notes.create
                "id": note.id
                "width":  note.width
                "height": note.height
                "top":  note.top
                "left": note.left
                "comment": "New note by " + $('#userdata').data 'current-user-email'
            comments.create id: note.id
        , 200

    stop_realtime_update_for_create: (note, event) =>
        clearInterval @interval_timer

    activate_note: (notes, note) =>
        self = @
        note.draggable
            start: (event) ->
                self.start_realtime_pos_update notes, $(@), event
            stop:  (event) ->
                self.stop_realtime_update notes, $(@), event

        note.resizable
            start: (event) ->
                self.start_realtime_size_update notes, $(@), event
            stop: (event) ->
                self.stop_realtime_update notes, $(@), event

        note.bind
            mouseenter: ->
                $(@).find('a.delete-note').clearQueue().fadeIn 100
            mouseleave: ->
                $(@).find('a.delete-note').clearQueue().fadeOut 100

    start_realtime_pos_update: (notes, note, event) =>
        note = $ note
        @interval_timer = setInterval =>
            notes.updatePos @build_note_object notes, note
        , 200

    start_realtime_size_update: (notes, note, event) =>
        note = $ note
        @interval_timer = setInterval =>
            notes.updateSize @build_note_object notes, note
        , 200

    stop_realtime_update: (notes, note, event) =>
        clearInterval @interval_timer
        noteObj = @build_note_object notes, note
        if noteObj.oldId?
            notes.commitUpdate noteObj

    build_note_object: (notes, obj) ->
        note = notes.get parseInt obj.data 'id'
        extension =
            "top":    parseInt obj.css  'top'
            "left":   parseInt obj.css  'left'
            "width":  parseInt obj.css  'width'
            "height": parseInt obj.css  'height'
        _.extend note, extension

window.Interactivity = Interactivity
