window.module = angular.module 'mockupGo', ['ui']

window.module.run ['$rootScope', ($rootScope) ->
    $rootScope.durations = window.durations
]