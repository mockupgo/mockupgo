_ = require 'lodash'
PusherMock = require '../pusherMock'
ServerMock = require '../serverMock'
testConfig = require './testConfig'
Notes = require '../Notes'
Comments = require '../Comments'

describe 'comments unit test', ->

    fakeViewModel =
        onUpdate: ->
        onUpdateComment: ->
        onDelete: ->

    tempNotesData =
        1: id: 1, left: 3, top: 5, width: 100, height: 50, comment: "first comm"
        2: id: 2, left: 0, top: 0, width: 150, height: 40, comment: "second comm"

    tempData =
        1: text: "first comm", id: 1
        2: text: "second comm", id: 2

    it 'should see that someone wrote comment in real time', ->
        pusherMock = new PusherMock
        anotherPusherMock = new PusherMock
        serverMock = new ServerMock null
        notes = new Notes fakeViewModel, pusherMock, serverMock
        otherNotes = new Notes fakeViewModel, anotherPusherMock, serverMock
        comments = new Comments fakeViewModel, pusherMock, serverMock, notes
        otherComments = new Comments fakeViewModel, anotherPusherMock, serverMock, otherNotes
        otherComments.subscribe()

        runs ->
            comments.create tempData[1]
            anotherPusherMock.send "client-new-note-comment-in-progress", tempData[1]

        waitsFor ->
            otherComments.count is 1
        , 'another user gets new comment', testConfig.timeouts.response

    it 'should see comment which was created before some user is logged', ->
        pusherMock = new PusherMock
        anotherPusherMock = new PusherMock
        serverMock = new ServerMock [pusherMock, anotherPusherMock]
        notes = new Notes fakeViewModel, pusherMock, serverMock
        comments = new Comments fakeViewModel, pusherMock, serverMock, notes
        comments.subscribe()
        otherNotes = {}
        otherComments = {}

        runs ->
            notes.create tempData[1]
            comments.create tempData[1]
            comments.commitCreate tempData[1].id

        waitsFor ->
            notes.count is 1 and _.isUndefined notes.data[1]
        , 'new note with new real id generated at server was added', testConfig.timeouts.response

        runs ->
            expect(comments.count).toBe 1
            otherNotes = new Notes fakeViewModel, anotherPusherMock, serverMock
            otherComments = new Comments fakeViewModel, anotherPusherMock, serverMock, otherNotes

        waitsFor ->
            otherComments.count is 1
        , 'another user got earlier created comment when logged', testConfig.timeouts.response
