exports = if typeof window is "undefined" then exports else window

class UserNotifications
    constructor: (@channel_rt, @scope) ->
        @login()
        @subscribeOtherMembers()

    login: =>
        @channel_rt.bind 'pusher:subscription_succeeded', (members) =>
            @me = members.me
            @me.id = @me.id.toString()
            @connectedUsers = {}
            @scope.$apply =>
                @connectedUsersCount = 0
            for id of members._members_map
                @addUser email:members._members_map[id].email, id:id

    subscribeOtherMembers: =>
        @channel_rt.bind 'pusher:member_added', (member) =>
            unless @connectedUsers[member.id]
                @addUser email:member.info.email, id:member.id

        @channel_rt.bind 'pusher:member_removed', (member) =>
            unless member is @me
                @removeUser email:member.info.email, id:member.id

    addUser: (user) =>
        @connectedUsers[user.id] = user
        @scope.$apply =>
            @connectedUsersCount++
            @scope.notifications["#{user.id}-yes"] = id:user.id.toString(), email:user.email, bLogIn:yes

    removeUser: (user) =>
        delete @connectedUsers[user.id]
        @scope.$apply =>
            @connectedUsersCount--
            @scope.notifications["#{user.id}-no"] = id:user.id.toString(), email:user.email, bLogIn:no

exports.UserNotifications = UserNotifications
config = require './config'
UserNotificationViewModel = (require './UserNotificationViewModel').UserNotificationViewModel
