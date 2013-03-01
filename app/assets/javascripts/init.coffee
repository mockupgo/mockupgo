if window?
    window.require = ->

    $ ->
        window.pusher = new window.Pusher window.pusherKey

        window.image_version_id = $('.current-version div[data-image-version]').attr("data-image-version")

        window.pusherService = new window.PusherService image_version_id
