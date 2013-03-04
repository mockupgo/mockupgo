class PusherService
    constructor: (image_version_id) ->
        @channel_rt = pusher.subscribe("presence-rt-update-image-version-" + image_version_id)
        window.channel_rt = @channel_rt

    subscribe: (method, handler) ->
        @channel_rt.bind method, handler

    send: (method, data) ->
        @channel_rt.trigger method, data

(if window? then window else exports).PusherService = PusherService
