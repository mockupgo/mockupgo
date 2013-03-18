// Generated by CoffeeScript 1.6.1
(function() {
  var Comments, _,
    _this = this;

  if ((typeof module !== "undefined" && module !== null ? module.exports : void 0) != null) {
    _ = require('lodash');
  } else {
    _ = window._;
  }

  Comments = (function() {

    function Comments(viewModel, pusher, server, notes) {
      var _this = this;
      this.viewModel = viewModel;
      this.pusher = pusher;
      this.server = server;
      this.notes = notes;
      this.update = function(comment) {
        return Comments.prototype.update.apply(_this, arguments);
      };
      this.commitCreate = function(id) {
        return Comments.prototype.commitCreate.apply(_this, arguments);
      };
      this.create = function(comment) {
        return Comments.prototype.create.apply(_this, arguments);
      };
      this.pop = function(id) {
        return Comments.prototype.pop.apply(_this, arguments);
      };
      this.push = function(comment, shouldUpdate) {
        if (shouldUpdate == null) {
          shouldUpdate = true;
        }
        return Comments.prototype.push.apply(_this, arguments);
      };
      this.subscribe = function() {
        return Comments.prototype.subscribe.apply(_this, arguments);
      };
      this.get = function(id) {
        return Comments.prototype.get.apply(_this, arguments);
      };
      this.init = function() {
        return Comments.prototype.init.apply(_this, arguments);
      };
      this.data = {};
      this.count = 0;
      this.init();
    }

    Comments.prototype.init = function() {
      var _this = this;
      return this.server.getComments(function(comments) {
        _.forEach(comments, function(comment) {
          return _this.push(_.cloneDeep(comment));
        });
        return _this.subscribe();
      });
    };

    Comments.prototype.get = function(id) {
      var _ref;
      return (_ref = this.data[id]) != null ? _ref.text : void 0;
    };

    Comments.prototype.subscribe = function() {
      var _this = this;
      return this.pusher.subscribe("client-new-note-comment-in-progress", function(comment) {
        return _this.push(comment);
      });
    };

    Comments.prototype.push = function(comment, shouldUpdate) {
      if (shouldUpdate == null) {
        shouldUpdate = true;
      }
      if (this.data[comment.id] == null) {
        this.count++;
      }
      this.data[comment.id] = comment;
      if (shouldUpdate) {
        return this.viewModel.onUpdateComment(comment);
      }
    };

    Comments.prototype.pop = function(id) {
      if (this.data[id] != null) {
        this.count--;
      }
      return delete this.data[id];
    };

    Comments.prototype.create = function(comment) {
      this.push(comment);
      return this.pusher.send("client-new-note-comment-in-progress", comment);
    };

    Comments.prototype.commitCreate = function(id) {
      return this.notes.commitCreate(this.notes.data[id]);
    };

    Comments.prototype.update = function(comment) {
      this.push(comment, false);
      return this.pusher.send("client-new-note-comment-in-progress", comment);
    };

    return Comments;

  })();

  if (typeof window !== "undefined" && window !== null) {
    window.Comments = Comments;
  } else {
    module.exports = Comments;
  }

}).call(this);