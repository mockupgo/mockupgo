// Generated by CoffeeScript 1.6.1
(function() {
  var PusherService;

  PusherService = (function() {

    function PusherService(image_version_id) {
      this.channel_rt = pusher.subscribe("presence-rt-update-image-version-" + image_version_id);
      window.channel_rt = this.channel_rt;
    }

    PusherService.prototype.subscribe = function(method, handler) {
      return this.channel_rt.bind(method, handler);
    };

    PusherService.prototype.send = function(method, data) {
      return this.channel_rt.trigger(method, data);
    };

    return PusherService;

  })();

  (typeof window !== "undefined" && window !== null ? window : exports).PusherService = PusherService;

}).call(this);