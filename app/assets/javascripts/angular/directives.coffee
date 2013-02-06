window.module.directive 'showNotifications', ->
    (scope, element, attrs) ->
        scope.$watch 'notifications', (value) ->
            angular.forEach value, (notification, index) ->
                return if $('.flash-message-box #'+index).length

                id = notification.id
                email = notification.email
                bLogIn = notification.bLogIn
                container = $ "<div>", class:"flash-message", style: "display:none", id: "presence_" + id
                message =  if id is scope.userNotifications.me.id then "You (#{email})" else "#{email} has"
                message += if bLogIn then " logged" else " exited"
                code = "<i class='icon-user icon-white' id='#{index}'></i> #{message}"
                html = container.html(code)
                                .fadeIn(scope.$parent.durations.fadein)
                                .delay(scope.$parent.durations.delay)
                                .fadeOut(scope.$parent.durations.fadeout)
                $('.flash-message-box').append html
                setTimeout ->
                    $(".flash-message-box ##{index}").parent().remove()
                , 3500

                delete scope.notifications[index]
        , true


