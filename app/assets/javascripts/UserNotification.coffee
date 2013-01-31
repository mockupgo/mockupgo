config = require './config'
UserNotificationViewModel = (require './UserNotificationViewModel').UserNotificationViewModel

class UserNotification
    constructor: (@email, @pusher) ->
        @notifications = []
        @viewModel = new UserNotificationViewModel()
        @subscribeOtherMembers()
        console.log "UNClass for " + @email + ": constructed"

    login: ->
        @pusher.send "subscribe", @email
        @pusher.receive "subscription_succeeded", =>
            console.log "UNClass for " + @email + ": login: user logged!!!"
            @logged = yes

    logout: ->
        @pusher.send "unsubscribe", @email
        @pusher.receive "unsubscription_succeeded", =>
            console.log "UNClass for " + @email + ": logout: user logged out!!!"
            @logged = no

    subscribeOtherMembers: ->
        for evt in ["member_added", "member_removed"]
            @pusher.subscribe evt, (member) =>
                @notifications.push member
                @viewModel.update @notifications
                console.log "UNClass for " + @email + ": notifications: " + JSON.stringify @notifications

                setTimeout =>
                    @notifications.splice @notifications.indexOf(member), 1
                    @viewModel.update @notifications
                    console.log "UNClass for " + @email + ": notifications: " + JSON.stringify @notifications
                , config.durations.notification

exports.UserNotification = UserNotification
