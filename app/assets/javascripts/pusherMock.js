// Generated by CoffeeScript 1.6.1
(function() {
  var PusherMock;

  PusherMock = (function() {

    function PusherMock() {
      this.subscriptions = {};
    }

    PusherMock.prototype.send = function(method, data) {
      var handler, subscription, _i, _len, _ref, _results;
      subscription = this.subscriptions[method];
      if (subscription == null) {
        return;
      }
      _ref = subscription.toHandle;
      _results = [];
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        handler = _ref[_i];
        _results.push(handler(data));
      }
      return _results;
    };

    PusherMock.prototype.subscribe = function(method, handler) {
      if (this.subscriptions[method] == null) {
        this.subscriptions[method] = {};
      }
      if (this.subscriptions[method].toHandle == null) {
        this.subscriptions[method].toHandle = [];
      }
      return this.subscriptions[method].toHandle.push(handler);
    };

    return PusherMock;

  })();

  module.exports = PusherMock;

}).call(this);