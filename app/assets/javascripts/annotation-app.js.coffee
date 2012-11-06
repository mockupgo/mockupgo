window.App = angular.module 'AnnotationApp', ['ngResource']


window.App.factory "AnnotationsService", ($resource) ->
  $resource "/image_versions/:image_version_id/annotations/:annotation_id"


window.App.controller 'annotationsCtrl',  ($scope, AnnotationsService) ->
    $scope.image_version_id = $('div[data-image-version]').attr("data-image-version")
    $scope.annotations = AnnotationsService.query({image_version_id: $scope.image_version_id})
