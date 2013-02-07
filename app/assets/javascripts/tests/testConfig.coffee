PusherMock = (require '../pusherMock').PusherMock

exports.timeouts =
    response : 100

exports.durations =
    maxWaitForEvent: 2000

makePusherMock = (id, email, alreadySigned) ->
    pusher = new PusherMock

    members_map = {}
    members_map[id] = id: id, email: email
    for u in alreadySigned
        members_map[u.id] = id: u.id, email: u.email

    pusher.when "subscription_succeeded", trigger:"subscription_succeeded", args: {me: {id:id,info:{email:email}}, _members_map:members_map}
    pusher.when "subscription_succeeded", trigger:"member_added", args: {id:id,info:{email:email}}

    pusher

exports.PusherMock = makePusherMock
