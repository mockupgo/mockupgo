UserNotificationViewModel = ($scope) ->
    unless window?
        $scope = $apply: (func) => func()

    $scope.notifications = {}
    @onChangeUsers = (user, bLogIn) =>
        $scope.$apply =>
            $scope.notifications["#{user.id}-#{bLogIn}"] = id:user.id.toString(), email:user.email, bLogIn:bLogIn

    return unless window?
    return if window.angularInit
    window.angularInit = true

    $scope.userNotifications = new UserNotification @, window.pusherService
    $scope.userNotifications.login()

(if window? then window else exports).UserNotificationViewModel = UserNotificationViewModel

