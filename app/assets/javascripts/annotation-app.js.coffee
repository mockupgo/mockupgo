window.app = angular.module 'AnnotationApp', []


window.app.factory 'AnnotationsService', ->
  lastRow = null


window.app.controller 'annotationsCtrl',  ($scope, AnnotationsService) ->
  # $scope.annotations = AnnotationsService.query()
    $scope.annotations = [{"comment":"This looks strange. Please change it...","created_at":"2012-10-26T19:56:56Z","height":61,"id":36,"image_version_id":133,"left":631,"top":1849,"updated_at":"2012-10-30T19:42:29Z","width":124},{"comment":"teqt qqsdf qsdf qs","created_at":"2012-10-30T19:42:00Z","height":52,"id":80,"image_version_id":133,"left":434,"top":400,"updated_at":"2012-10-30T19:42:08Z","width":174},{"comment":"qsdf","created_at":"2012-10-30T21:11:24Z","height":105,"id":87,"image_version_id":133,"left":36,"top":36,"updated_at":"2012-10-30T21:39:24Z","width":207},{"comment":"qsdf","created_at":"2012-10-30T21:30:46Z","height":39,"id":95,"image_version_id":133,"left":507,"top":228,"updated_at":"2012-10-30T21:30:49Z","width":60},{"comment":"qsdfqsdf","created_at":"2012-10-30T21:30:52Z","height":44,"id":96,"image_version_id":133,"left":57,"top":519,"updated_at":"2012-10-30T21:39:29Z","width":73},{"comment":"qsdfqsdfqsdf","created_at":"2012-10-30T21:30:57Z","height":84,"id":97,"image_version_id":133,"left":424,"top":604,"updated_at":"2012-10-30T21:39:33Z","width":190}]