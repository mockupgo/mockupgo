// Generated by CoffeeScript 1.4.0
(function() {
  var Notes, PusherMock, ServerMock, testConfig, _;

  _ = require('lodash');

  PusherMock = require('../pusherMock');

  ServerMock = require('../serverMock');

  testConfig = require('./testConfig');

  Notes = require('../Notes');

  describe('notes unit tests', function() {
    var fakeViewModel, tempData;
    fakeViewModel = {
      onUpdate: function() {},
      onDelete: function() {}
    };
    tempData = {
      1: {
        id: 1,
        left: 3,
        top: 5,
        width: 100,
        height: 50
      },
      2: {
        id: 2,
        left: 0,
        top: 0,
        width: 150,
        height: 40
      }
    };
    it('should see that someone created a note in real time', function() {
      var anotherPusherMock, notes, otherNotes, pusherMock, serverMock;
      pusherMock = new PusherMock;
      anotherPusherMock = new PusherMock;
      serverMock = new ServerMock(null);
      notes = new Notes(fakeViewModel, pusherMock, serverMock);
      otherNotes = new Notes(fakeViewModel, anotherPusherMock, serverMock);
      otherNotes.subscribe();
      runs(function() {
        notes.create(tempData[1]);
        return anotherPusherMock.send("client-new-note-in-progress", tempData[1]);
      });
      return waitsFor(function() {
        return otherNotes.count === 1;
      }, 'another user gets new note', testConfig.timeouts.response);
    });
    it('should see a note which was created before some user is logged', function() {
      var anotherPusherMock, notes, otherNotes, pusherMock, serverMock;
      pusherMock = new PusherMock;
      anotherPusherMock = new PusherMock;
      serverMock = new ServerMock([pusherMock, anotherPusherMock]);
      notes = new Notes(fakeViewModel, pusherMock, serverMock);
      notes.subscribe();
      otherNotes = {};
      runs(function() {
        notes.create(tempData[1]);
        return notes.commitCreate(tempData[1]);
      });
      waitsFor(function() {
        return notes.count === 1 && _.isUndefined(notes.data[1]);
      }, 'new note with new real id generated at server was added', testConfig.timeouts.response);
      runs(function() {
        return otherNotes = new Notes(fakeViewModel, anotherPusherMock, serverMock);
      });
      return waitsFor(function() {
        return otherNotes.count === 1;
      }, 'another user got earlier created note when logged', testConfig.timeouts.response);
    });
    it('should see that someone changes note size and position in real time', function() {
      var anotherPusherMock, newData, notes, otherNotes, pusherMock, serverMock;
      pusherMock = new PusherMock;
      anotherPusherMock = new PusherMock;
      serverMock = new ServerMock([pusherMock, anotherPusherMock]);
      serverMock.notes = tempData;
      notes = new Notes(fakeViewModel, pusherMock, serverMock);
      otherNotes = new Notes(fakeViewModel, anotherPusherMock, serverMock);
      otherNotes.subscribe();
      newData = {
        id: 2,
        left: 0,
        top: 0,
        width: 50,
        height: 40
      };
      runs(function() {
        notes.updateSize(newData);
        return notes.commitUpdate(newData);
      });
      waitsFor(function() {
        return _.isEqual(otherNotes.get(2), newData);
      }, 'another user gets changes of 2nd note size', testConfig.timeouts.response * 2);
      newData = {
        id: 2,
        left: 10,
        top: 20,
        width: 50,
        height: 40
      };
      runs(function() {
        notes.updatePos(newData);
        return notes.commitUpdate(newData);
      });
      return waitsFor(function() {
        return _.isEqual(otherNotes.get(2), newData);
      }, 'another user gets changes of 2nd note position', testConfig.timeouts.response * 2);
    });
    it('should save note update on server', function() {
      var newData, notes, pusherMock, serverMock;
      pusherMock = new PusherMock;
      serverMock = new ServerMock([pusherMock]);
      serverMock.notes = tempData;
      notes = new Notes(fakeViewModel, pusherMock, serverMock);
      newData = {
        id: 2,
        left: 10,
        top: 20,
        width: 50,
        height: 40
      };
      runs(function() {
        notes.updateSize(newData);
        notes.updatePos(newData);
        return notes.commitUpdate(newData);
      });
      return waitsFor(function() {
        return _.isEqual(serverMock.notes[newData.id], newData);
      }, 'server got commit', testConfig.timeouts.response);
    });
    it('should see that someone deleted a note', function() {
      var anotherPusherMock, notes, otherNotes, pusherMock, serverMock;
      pusherMock = new PusherMock;
      anotherPusherMock = new PusherMock;
      serverMock = new ServerMock([pusherMock, anotherPusherMock]);
      serverMock.notes = _.cloneDeep(tempData);
      notes = new Notes(fakeViewModel, pusherMock, serverMock);
      otherNotes = new Notes(fakeViewModel, anotherPusherMock, serverMock);
      otherNotes.subscribe();
      expect(notes.count).toBe(2);
      expect(otherNotes.count).toBe(2);
      runs(function() {
        notes["delete"](tempData[2].id);
        notes.commitDelete(tempData[2].id);
        return anotherPusherMock.send("client-delete-note-in-progress", tempData[2]);
      });
      return waitsFor(function() {
        return notes.count === 1 && otherNotes.count === 1;
      }, 'another user saw that 2nd note was deleted', testConfig.timeouts.response);
    });
    return it('should delete note from server', function() {
      var notes, pusherMock, serverMock;
      pusherMock = new PusherMock;
      serverMock = new ServerMock([pusherMock]);
      serverMock.notes = _.cloneDeep(tempData);
      notes = new Notes(fakeViewModel, pusherMock, serverMock);
      runs(function() {
        notes["delete"](tempData[2].id);
        return notes.commitDelete(tempData[2].id);
      });
      return waitsFor(function() {
        return _.isUndefined(serverMock.notes[tempData[2].id]);
      }, 'note was deleted from server', testConfig.timeouts.response);
    });
  });

}).call(this);