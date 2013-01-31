PusherMock = (require '../pusherMock').PusherMock

exports.timeouts =
    response : 100

exports.durations =
    maxWaitForEvent: 2000

makePusherMock = ->
    pusher = new PusherMock

    pusher.when "subscribe", trigger: "subscription_succeeded"
    pusher.when "subscribe", trigger: "member_added", args: {name: "abc"}

    pusher.when "unsubscribe", trigger: "unsubscription_succeeded"
    pusher.when "unsubscribe", trigger: "member_removed", args: {name: "abc"}

    pusher

exports.PusherMock = makePusherMock()
