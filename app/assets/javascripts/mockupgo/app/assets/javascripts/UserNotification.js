//@ sourceMappingURL=mockupgo\app\assets\javascripts\mockupgo\app\assets\javascripts\UserNotification.map
// Generated by CoffeeScript 1.6.1
(function() {
  var UserNotification,
    _this = this;

  UserNotification = (function() {

    function UserNotification(viewModel, pusher) {
      var _this = this;
      this.viewModel = viewModel;
      this.pusher = pusher;
      this.removeUser = function(user) {
        return UserNotification.prototype.removeUser.apply(_this, arguments);
      };
      this.addUser = function(user) {
        return UserNotification.prototype.addUser.apply(_this, arguments);
      };
      this.subscribeOtherMembers = function() {
        return UserNotification.prototype.subscribeOtherMembers.apply(_this, arguments);
      };
      this.login = function() {
        return UserNotification.prototype.login.apply(_this, arguments);
      };
      this.connectedUsers = {};
      this.connectedUsersCount = 0;
    }

    UserNotification.prototype.login = function() {
      var _this = this;
      return this.pusher.subscribe("pusher:subscription_succeeded", function(members) {
        var id;
        _this.me = members.me;
        _this.me.id = _this.me.id.toString();
        for (id in members._members_map) {
          _this.addUser({
            email: members._members_map[id].email,
            id: id
          });
        }
        return _this.subscribeOtherMembers();
      });
    };

    UserNotification.prototype.subscribeOtherMembers = function() {
      var _this = this;
      this.pusher.subscribe("pusher:member_added", function(member) {
        if (!_this.connectedUsers[member.id]) {
          return _this.addUser({
            email: member.info.email,
            id: member.id
          });
        }
      });
      return this.pusher.subscribe("pusher:member_removed", function(member) {
        if (member !== _this.me) {
          return _this.removeUser({
            email: member.info.email,
            id: member.id
          });
        }
      });
    };

    UserNotification.prototype.addUser = function(user) {
      this.connectedUsersCount++;
      this.connectedUsers[user.id] = user;
      return this.viewModel.onChangeUsers(user, true);
    };

    UserNotification.prototype.removeUser = function(user) {
      delete this.connectedUsers[user.id];
      this.connectedUsersCount--;
      return this.viewModel.onChangeUsers(user, false);
    };

    return UserNotification;

  })();

  if (typeof window !== "undefined" && window !== null) {
    window.UserNotification = UserNotification;
  } else {
    module.exports = UserNotification;
  }

}).call(this);
