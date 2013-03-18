// Generated by CoffeeScript 1.6.1
(function() {
  var UserNotificationViewModel;

  UserNotificationViewModel = function($scope) {
    var _this = this;
    if (typeof window === "undefined" || window === null) {
      $scope = {
        $apply: function(func) {
          return func();
        }
      };
    }
    $scope.notifications = {};
    this.onChangeUsers = function(user, bLogIn) {
      return $scope.$apply(function() {
        return $scope.notifications["" + user.id + "-" + bLogIn] = {
          id: user.id.toString(),
          email: user.email,
          bLogIn: bLogIn
        };
      });
    };
    if (typeof window === "undefined" || window === null) {
      return;
    }
    if (window.angularInit) {
      return;
    }
    window.angularInit = true;
    return $(function() {
      $scope.userNotifications = new UserNotification(_this, window.pusherService);
      return $scope.userNotifications.login();
    });
  };

  if (typeof window !== "undefined" && window !== null) {
    window.UserNotificationViewModel = UserNotificationViewModel;
  } else {
    module.exports = UserNotificationViewModel;
  }

}).call(this);