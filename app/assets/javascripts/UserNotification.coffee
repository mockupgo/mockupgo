config = require './config'
UserNotificationViewModel = (require './UserNotificationViewModel').UserNotificationViewModel

class UserNotification
    constructor: (@email, @pusher) ->
        @notifications = []
        @viewModel = new UserNotificationViewModel()
        @subscribeOtherMembers()

    login: ->
        @pusher.send "subscribe", @email
        @pusher.receive "subscription_succeeded", =>
            console.log "user logged!!!"
            @logged = yes

    logout: ->
        @pusher.send "unsubscribe", @email
        @pusher.receive "unsubscription_succeeded", =>
            @logged = no

    subscribeOtherMembers: ->
        for evt in ["member_added", "member_removed"]
            @pusher.subscribe evt, (member) =>
                @notifications.push member
                @viewModel.update @notifications

                setTimeout =>
                    @notifications.splice @notifications.indexOf(member), 1
                    @viewModel.update @notifications
                , config.durations.notification

exports.UserNotification = UserNotification
