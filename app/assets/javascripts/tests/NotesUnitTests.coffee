_ = require 'lodash'
PusherMock = require '../pusherMock'
ServerMock = require '../serverMock'
testConfig = require './testConfig'
Notes = require '../Notes'

describe 'notes unit tests', ->

    fakeViewModel =
        onUpdate: ->
        onDelete: ->

    tempData =
        1: id: 1, left: 3, top: 5, width: 100, height: 50
        2: id: 2, left: 0, top: 0, width: 150, height: 40

    it 'should see that someone created a note in real time', ->
        pusherMock = new PusherMock
        anotherPusherMock = new PusherMock
        serverMock = new ServerMock null
        notes = new Notes fakeViewModel, pusherMock, serverMock
        otherNotes = new Notes fakeViewModel, anotherPusherMock, serverMock
        otherNotes.subscribe()

        runs ->
            notes.create tempData[1]
            anotherPusherMock.send "client-new-note-in-progress", tempData[1]

        waitsFor ->
            otherNotes.count is 1
        , 'another user gets new note', testConfig.timeouts.response

    it 'should see a note which was created before some user is logged', ->
        pusherMock = new PusherMock
        anotherPusherMock = new PusherMock
        serverMock = new ServerMock [pusherMock, anotherPusherMock]
        notes = new Notes fakeViewModel, pusherMock, serverMock
        notes.subscribe()
        otherNotes = {}

        runs ->
            notes.create tempData[1]
            notes.commitCreate tempData[1]

        waitsFor ->
            notes.count is 1 && _.isUndefined notes.data[1]
        , 'new note with new real id generated at server was added', testConfig.timeouts.response

        runs ->
            otherNotes = new Notes fakeViewModel, anotherPusherMock, serverMock

        waitsFor ->
            otherNotes.count is 1
        , 'another user got earlier created note when logged', testConfig.timeouts.response

    it 'should see that someone changes note size and position in real time', ->
        pusherMock = new PusherMock
        anotherPusherMock = new PusherMock
        serverMock = new ServerMock [pusherMock, anotherPusherMock]
        serverMock.notes = tempData
        notes = new Notes fakeViewModel, pusherMock, serverMock
        otherNotes = new Notes fakeViewModel, anotherPusherMock, serverMock
        otherNotes.subscribe()

        newData = id: 2, left: 0, top: 0, width: 50, height: 40

        runs ->
            notes.updateSize newData
            notes.commitUpdate newData

        waitsFor ->
            _.isEqual otherNotes.get(2), newData
        , 'another user gets changes of 2nd note size', testConfig.timeouts.response * 2

        newData = id: 2, left: 10, top: 20, width: 50, height: 40

        runs ->
            notes.updatePos newData
            notes.commitUpdate newData

        waitsFor ->
            _.isEqual otherNotes.get(2), newData
        , 'another user gets changes of 2nd note position', testConfig.timeouts.response * 2

    it 'should save note update on server', ->
        pusherMock = new PusherMock
        serverMock = new ServerMock [pusherMock]
        serverMock.notes = tempData
        notes = new Notes fakeViewModel, pusherMock, serverMock

        newData = id: 2, left: 10, top: 20, width: 50, height: 40

        runs ->
            notes.updateSize newData
            notes.updatePos newData
            notes.commitUpdate newData

        waitsFor ->
            _.isEqual serverMock.notes[newData.id], newData
        , 'server got commit', testConfig.timeouts.response

    it 'should see that someone deleted a note', ->
        pusherMock = new PusherMock
        anotherPusherMock = new PusherMock
        serverMock = new ServerMock [pusherMock, anotherPusherMock]
        serverMock.notes = _.cloneDeep tempData
        notes = new Notes fakeViewModel, pusherMock, serverMock
        otherNotes = new Notes fakeViewModel, anotherPusherMock, serverMock
        otherNotes.subscribe()

        expect(notes.count).toBe 2
        expect(otherNotes.count).toBe 2

        runs ->
            notes.commitDelete tempData[2].id
            notes.delete tempData[2].id
            anotherPusherMock.send "client-delete-note-in-progress", tempData[2]

        waitsFor ->
            notes.count is 1 && otherNotes.count is 1
        , 'another user saw that 2nd note was deleted', testConfig.timeouts.response

    it 'should delete note from server', ->
        pusherMock = new PusherMock
        serverMock = new ServerMock [pusherMock]
        serverMock.notes = _.cloneDeep tempData
        notes = new Notes fakeViewModel, pusherMock, serverMock

        runs ->
            notes.commitDelete tempData[2].id
            notes.delete tempData[2].id

        waitsFor ->
            _.isUndefined serverMock.notes[tempData[2].id]
        , 'note was deleted from server', testConfig.timeouts.response
