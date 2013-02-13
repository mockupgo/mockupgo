config = require '../config'
testConfig = require './testConfig'
_ = require 'lodash'
Notes = (require '../Notes').Notes

describe 'notes unit tests', ->

    fakeViewModel =
        onUpdate: ->
        onDelete: ->

    tempData =
        1: id: 1, left: 3, top: 5, width: 100, height: 50
        2: id: 2, left: 0, top: 0, width: 150, height: 40

    it 'should see that someone created a note in real time', ->
        notes = new Notes fakeViewModel, testConfig.PusherMock, testConfig.ServerMock
        otherNotes = new Notes
        runs ->
            notes.create tempData[1]

        waitsFor ->
            otherNotes.count is 1
        , 'another user gets new note', config.timeouts.response

    it 'should see that someone created a note before he logged', ->
        notes = new Notes fakeViewModel, testConfig.PusherMock, testConfig.ServerMock
        otherNotes

        runs ->
            notes.create tempData[1]
            notes.commitCreate tempData[1]

        waitsFor ->
            notes.count is 1
        , 'new note is added', config.timeouts.response

        runs ->
            otherNotes = new Notes fakeViewModel, testConfig.PusherMock, testConfig.ServerMock
        waitsFor ->
            otherNotes.count is 1
        , 'another user got earlier created note when logged', config.timeouts.response

    it 'should see that someone changes note size and position in real time', ->
        notes = new Notes fakeViewModel, testConfig.PusherMock, testConfig.ServerMock
        otherNotes = new Notes fakeViewModel, testConfig.PusherMock, testConfig.ServerMock
        notes.data = tempData
        otherNotes.data = tempData

        newData = id: 2, left: 0, top: 0, width: 50, height: 40

        runs ->
            notes.updateSize newData

        waitsFor ->
            _.isEqual otherNotes.get(2), newData
        , 'another user gets changes of 2nd note size', config.timeouts.response * 2

        newData = id: 2, left: 10, top: 20, width: 50, height: 40

        runs ->
            notes.updatePos newData

        waitsFor ->
            _.isEqual otherNotes.get(2), newData
        , 'another user gets changes of 2nd note position', config.timeouts.response * 2

    it 'should save note update on server', ->
        notes = new Notes fakeViewModel, testConfig.PusherMock, testConfig.ServerMock
        notes.data = tempData

        newData = id: 2, left: 10, top: 20, width: 50, height: 40

        runs ->
            notes.updateSize newData
            notes.updatePos newData
            notes.commitUpdate newData

        waitsFor ->
            _.isEqual testConfig.ServerMock.notes[newData.id], newData
        , 'server got commit', config.timeouts.response

    it 'should see that someone deleted a note', ->
        tempData =
            1: left: 3, top: 5, width: 100, height: 50
            2: left: 0, top: 0, width: 150, height: 40

        notes = new Notes fakeViewModel, testConfig.PusherMock, testConfig.ServerMock
        otherNotes = new Notes fakeViewModel, testConfig.PusherMock, testConfig.ServerMock
        notes.data = tempData
        otherNotes.data = tempData

        expect(notes.count).toBe 2
        expect(otherNotes.count).toBe 2

        runs ->
            notes.delete 2

        waitsFor ->
            otherNotes.count is 1
        , 'another user saw that 2nd note was deleted', config.timeouts.response

    it 'should delete note from server', ->
        notes = new Notes fakeViewModel, testConfig.PusherMock, testConfig.ServerMock
        notes.data = tempData

        runs ->
            notes.delete tempData[2]

        waitsFor ->
            _.isUndefined testConfig.ServerMock.notes[tempData[2].id]
        , 'note was deleted from server', config.timeouts.response
