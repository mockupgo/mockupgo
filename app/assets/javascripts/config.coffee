durations =
    notification : 4000
    fadein : 1000
    delay : 2000
    fadeout : 1000

if window?
    window.durations = durations
else
    module.exports = durations


