_ = require 'lodash' if exports
class Comments
    constructor: (@viewModel, @pusher, @server, @notes) ->
        @data = {}
        @count = 0
        @init()

    init: =>
        @server.getComments (comments) =>
            _.forEach comments, (comment) =>
                @push _.cloneDeep comment
            @subscribe()

    subscribe: =>
        @pusher.subscribe "client-new-note-comment-in-progress", (comment) =>
            @push comment

    push: (comment) =>
        @count++ unless @data[comment.id]?
        @data[comment.id] = comment
        @viewModel.onUpdate comment

    pop: (id) =>
        @count-- if @data[id]?
        delete @data[id]
        @viewModel.onDelete id

    create: (comment) =>
        @push comment
        @pusher.send "client-new-note-comment-in-progress", comment

    commitCreate: (comment) =>
        @notes.data[comment.id].comment = comment.text
        @notes.commitCreate @notes.data[comment.id]

(if window? then window else exports).Comments = Comments
