durations =
    notification : 4000
    fadein : 1000
    delay : 2000
    fadeout : 1000

exports = if typeof window is "undefined" then exports else window
exports.durations = durations
