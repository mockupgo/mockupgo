window.module = angular.module 'mockupGo', ['ui']

window.module.run ['$rootScope', '$compile', ($rootScope, $compile) ->
    $rootScope.durations = window.durations
    $rootScope.interactivity = new window.Interactivity
]
