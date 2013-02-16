durations =
    notification : 4000
    fadein : 1000
    delay : 2000
    fadeout : 1000

# server = new ServerService
# window.server = server

# image_version_id = $('.current-version div[data-image-version]').attr("data-image-version")
# window.image_version_id = image_version_id

# pusher = new PusherService image_version_id
# window.pusher = pusher

window = if window? then window else exports
window.durations = durations
