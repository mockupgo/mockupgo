class UserNotification
    constructor: (@viewModel, @pusher) ->
        @connectedUsers = {}
        @connectedUsersCount = 0

    login: =>
        @pusher.subscribe "pusher:subscription_succeeded", (members) =>
            @me = members.me
            @me.id = @me.id.toString()
            for id of members._members_map
                @addUser email:members._members_map[id].email, id:id
            @subscribeOtherMembers()

    subscribeOtherMembers: =>
        @pusher.subscribe "pusher:member_added", (member) =>
            unless @connectedUsers[member.id]
                @addUser email:member.info.email, id:member.id

        @pusher.subscribe "pusher:member_removed", (member) =>
            unless member is @me
                @removeUser email:member.info.email, id:member.id

    addUser: (user) =>
        @connectedUsersCount++
        @connectedUsers[user.id] = user
        @viewModel.onChangeUsers user, true

    removeUser: (user) =>
        delete @connectedUsers[user.id]
        @connectedUsersCount--
        @viewModel.onChangeUsers user, false

if window?
    window.UserNotification = UserNotification
else
    module.exports = UserNotification
