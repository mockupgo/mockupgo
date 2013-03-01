_ = require 'lodash'
PusherMock = (require '../pusherMock').PusherMock
ServerMock = (require '../serverMock').ServerMock
testConfig = require './testConfig'
Notes = (require '../Notes').Notes
Comments = (require '../Comments').Comments

describe 'comments unit test', ->

    fakeViewModel =
        onUpdate: ->
        onDelete: ->

    tempNotesData =
        1: id: 1, left: 3, top: 5, width: 100, height: 50
        2: id: 2, left: 0, top: 0, width: 150, height: 40

    tempData =
        1: text: "first comm", id: 1
        2: text: "second comm", id: 2

    it 'should see that someone wrote comment in real time', ->
        pusherMock = new PusherMock
        anotherPusherMock = new PusherMock
        serverMock = new ServerMock null
        comments = new Comments fakeViewModel, pusherMock, serverMock, null
        otherComments = new Comments fakeViewModel, anotherPusherMock, serverMock, null
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
            comments.commitCreate tempData[1]

        waitsFor ->
            notes.count is 1 && _.isUndefined notes.data[1]
        , 'new note with new real id generated at server was added', testConfig.timeouts.response

        runs ->
            expect(comments.count).toBe 1
            otherNotes = new Notes fakeViewModel, anotherPusherMock, serverMock
            otherComments = new Comments fakeViewModel, anotherPusherMock, serverMock, otherNotes

        waitsFor ->
            otherComments.count is 1
        , 'another user got earlier created comment when logged', testConfig.timeouts.response
