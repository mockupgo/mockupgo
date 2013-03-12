if module?.exports?
    _ = require 'lodash'
else
    _ = window._

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

    get: (id) =>
        @data[id]?.text

    subscribe: =>
        @pusher.subscribe "client-new-note-comment-in-progress", (comment) =>
            @push comment

    push: (comment, shouldUpdate = yes) =>
        @count++ unless @data[comment.id]?
        @data[comment.id] = comment
        @viewModel.onUpdateComment comment if shouldUpdate

    pop: (id) =>
        @count-- if @data[id]?
        delete @data[id]

    create: (comment) =>
        @push comment
        @pusher.send "client-new-note-comment-in-progress", comment

    commitCreate: (id) =>
        @notes.commitCreate @notes.data[id]

    update: (comment) =>
        @push comment, no
        @pusher.send "client-new-note-comment-in-progress", comment


if window?
    window.Comments = Comments
else
    module.exports = Comments
