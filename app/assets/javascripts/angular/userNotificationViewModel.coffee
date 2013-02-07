UserNotificationViewModel = ($scope, $timeout) ->
    unless window?
        $scope = $apply: (func) => func()

    $scope.notifications = {}
    @onChangeUsers = (user, bLogIn) =>
        $scope.$apply =>
            $scope.notifications["#{user.id}-#{bLogIn}"] = id:user.id.toString(), email:user.email, bLogIn:bLogIn

    return unless window?
    return if window.angularInit
    window.angularInit = true

    image_version_id = $('.current-version div[data-image-version]').attr("data-image-version")
    window.image_version_id = image_version_id

    pusher = new PusherService image_version_id
    $scope.userNotifications = new UserNotification @, pusher
    $scope.userNotifications.login()

(if window? then window else exports).UserNotificationViewModel = UserNotificationViewModel

