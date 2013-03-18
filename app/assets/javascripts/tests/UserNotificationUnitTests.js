// Generated by CoffeeScript 1.4.0
(function() {
  var PusherMock, UserNotification, UserNotificationViewModel, config, testConfig;

  config = require('../config');

  testConfig = require('./testConfig');

  PusherMock = require('../pusherMock');

  UserNotification = require('../UserNotification');

  UserNotificationViewModel = require('../angular/UserNotificationViewModel');

  describe('user notification unit tests', function() {
    var createMemberMap;
    createMemberMap = function(users) {
      var map, user, _i, _len;
      map = {};
      for (_i = 0, _len = users.length; _i < _len; _i++) {
        user = users[_i];
        map[user.id] = {
          id: user.id,
          email: user.info.email
        };
      }
      return map;
    };
    it('should be logged in after login()', function() {
      var pusherMock, user, userNotification, viewModel;
      viewModel = new UserNotificationViewModel;
      pusherMock = new PusherMock;
      userNotification = new UserNotification(viewModel, pusherMock);
      user = {
        id: 1,
        info: {
          email: "abc@gmail.com"
        }
      };
      runs(function() {
        userNotification.login();
        return pusherMock.send("pusher:subscription_succeeded", {
          me: user,
          _members_map: createMemberMap([user])
        });
      });
      waitsFor(function() {
        return userNotification.me != null;
      }, 'user objects exists', testConfig.timeouts.response);
      return runs(function() {
        return expect(userNotification.connectedUsersCount).toBe(1);
      }, 'user logged in', testConfig.timeouts.response);
    });
    it('should know about another users are logged before or after own login()', function() {
      var anotherPusherMock, anotherUser, anotherUserNotification, pusherMock, user, userNotification, viewModel;
      viewModel = new UserNotificationViewModel;
      pusherMock = new PusherMock;
      anotherPusherMock = new PusherMock;
      userNotification = new UserNotification(viewModel, pusherMock);
      anotherUserNotification = new UserNotification(viewModel, anotherPusherMock);
      user = {
        id: 1,
        info: {
          email: "abc@gmail.com"
        }
      };
      anotherUser = {
        id: 2,
        info: {
          email: "def@gmail.com"
        }
      };
      runs(function() {
        userNotification.login();
        return pusherMock.send("pusher:subscription_succeeded", {
          me: user,
          _members_map: createMemberMap([user])
        });
      });
      waitsFor(function() {
        return userNotification.me != null;
      }, 'first user logged in while another didnt yet', testConfig.timeouts.response);
      runs(function() {
        anotherUserNotification.login();
        anotherPusherMock.send("pusher:subscription_succeeded", {
          me: anotherUser,
          _members_map: createMemberMap([user, anotherUser])
        });
        return pusherMock.send("pusher:member_added", anotherUser);
      });
      waitsFor(function() {
        return anotherUserNotification.me != null;
      }, 'another user logged in after the first did', testConfig.timeouts.response);
      return runs(function() {
        expect(userNotification.connectedUsersCount).toBe(2);
        return expect(anotherUserNotification.connectedUsersCount).toBe(2);
      });
    });
    return it('should update connected users list on member_removed', function() {
      var anotherUser, pusherMock, user, userNotification, viewModel;
      viewModel = new UserNotificationViewModel;
      pusherMock = new PusherMock;
      userNotification = new UserNotification(viewModel, pusherMock);
      user = {
        id: 1,
        info: {
          email: "abc@gmail.com"
        }
      };
      anotherUser = {
        id: 2,
        info: {
          email: "def@gmail.com"
        }
      };
      runs(function() {
        userNotification.login();
        return pusherMock.send("pusher:subscription_succeeded", {
          me: user,
          _members_map: createMemberMap([user])
        });
      });
      waitsFor(function() {
        return userNotification.me != null;
      }, 'user logged in', testConfig.timeouts.response);
      runs(function() {
        return pusherMock.send("pusher:member_added", anotherUser);
      });
      waitsFor(function() {
        return userNotification.connectedUsersCount === 2;
      }, 'another user was added', testConfig.timeouts.response);
      runs(function() {
        return pusherMock.send('pusher:member_removed', anotherUser);
      });
      return waitsFor(function() {
        return userNotification.connectedUsersCount === 1;
      }, 'another user was removed', testConfig.timeouts.response);
    });
  });

}).call(this);
