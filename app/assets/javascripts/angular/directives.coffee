window.module.directive 'showNotifications', ->
    (scope, element, attrs) ->
        scope.$watch 'connectedUsers', (value) ->
            console.log 'directive worked'
        , true


