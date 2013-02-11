config = require '../config'
testConfig = require './testConfig'
_ = require 'lodash'

describe 'notes unit tests', ->

    it 'should see that someone created a note', ->
        notes = new Notes
        otherNotes = new Notes
        runs ->
            notes.add id: 1

        waitsFor ->
            otherNotes.count is 1
        , 'another user gets new note', config.timeouts.response

    it 'should see that someone created a note', ->
        notes = new Notes
        otherNotes

        runs ->
            notes.add id: 1

        waitsFor ->
            notes.count is 1
        , 'new note is added', config.timeouts.response

        runs ->
            otherNotes = new Notes
        waitsFor ->
            otherNotes.count is 1
        , 'another user got earlier created note when logged', config.timeouts.response

    it 'should see that someone changes note size', ->
        tempData =
            1: left: 3, top: 5, width: 100, height: 50
            2: left: 0, top: 0, width: 150, height: 40

        notes = new Notes
        otherNotes = new Notes
        notes.data = tempData
        otherNotes.data = tempData

        newData = left: 5, top: 0, width: 150, height: 40

        runs ->
            notes.update 2, newData

        waitsFor ->
            _.isEqual otherNotes.get(2), newData
        , 'another user gets changes of 2nd note size', config.timeouts.response * 2

    it 'should see that someone deleted a note', ->
        tempData =
            1: left: 3, top: 5, width: 100, height: 50
            2: left: 0, top: 0, width: 150, height: 40

        notes = new Notes
        otherNotes = new Notes
        notes.data = tempData
        otherNotes.data = tempData

        expect(notes.count).toBe 2
        expect(otherNotes.count).toBe 2

        runs ->
            notes.delete 2

        waitsFor ->
            otherNotes.count is 1
        , 'another user saw that 2nd note was deleted', config.timeouts.response
