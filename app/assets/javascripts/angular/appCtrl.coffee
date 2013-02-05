window.appCtrl = ($scope, $timeout) ->

    image_version_id = $('.current-version div[data-image-version]').attr("data-image-version")
    channel_rt = pusher.subscribe("presence-rt-update-image-version-" + image_version_id)
    window.channel_rt = channel_rt
    window.image_version_id = image_version_id

    channel_rt.bind 'pusher:subscription_succeeded', (members) ->
        $scope.$apply ->
            $scope.me = members.me
            $scope.connectedUsers = {}
            $scope.connectedUsersCount = 0
            angular.forEach members._members_map, (member, id) ->
                $scope.addUser email:member.email, id:id


    channel_rt.bind 'pusher:member_added', (member) ->
        $scope.$apply ->
            unless $scope.connectedUsers[member.id]
                $scope.addUser email:member.info.email, id:member.id

    channel_rt.bind 'pusher:member_removed', (member) ->
        $scope.$apply ->
            unless member is $scope.me
                $scope.removeUser email:member.info.email, id:member.id

    $scope.addUser = (user) ->
        $scope.connectedUsers[user.id] = user
        $scope.connectedUsersCount++
        notify user.id, user.email, yes

    $scope.removeUser = (user) ->
        delete $scope.connectedUsers[user.id]
        $scope.connectedUsersCount--
        notify user.id, user.email, no

    notify = (id, email, bLogIn) ->
        divId = id + "-" + bLogIn
        unless $('.flash-message-box #'+divId).length
            container = $ "<div>", class:"flash-message", style: "display:none", id: "presence_" + id
            message = (if id.toString() is $scope.me.id.toString() then "You ("+email+")" else email + " has") + if bLogIn then " logged" else " exited"
            code = "<i class='icon-user icon-white' id='"+divId+"'></i> " + message
            $('.flash-message-box').append container.html(code).fadeIn(1000).delay(1500).fadeOut(1000)
            setTimeout ->
                $('.flash-message-box #'+divId).parent().remove()
            , 3500

config = (require '../config.coffee').durations
