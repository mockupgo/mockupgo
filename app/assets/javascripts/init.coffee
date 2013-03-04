$ ->
    window.pusher = new window.Pusher window.pusherKey

    window.pusherService = new window.PusherService $('.current-version div[data-image-version]').attr("data-image-version")
