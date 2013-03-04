config = require '../config'
testConfig = require './testConfig'
PusherMock = require '../pusherMock'
UserNotification = require '../UserNotification'
UserNotificationViewModel = require '../angular/UserNotificationViewModel'

describe 'user notification unit tests', ->

    createMemberMap = (users) ->
        map = {}
        for user in users
            map[user.id] = id: user.id, email: user.info.email
        map


    it 'should be logged in after login()', ->
        viewModel = new UserNotificationViewModel
        pusherMock = new PusherMock
        userNotification = new UserNotification viewModel, pusherMock
        user = id: 1, info: email: "abc@gmail.com"
        runs ->
            userNotification.login()
            pusherMock.send "pusher:subscription_succeeded", me: user, _members_map: createMemberMap [user]

        waitsFor ->
            userNotification.me?
        , 'user objects exists', testConfig.timeouts.response

        runs ->
            expect(userNotification.connectedUsersCount).toBe 1
        , 'user logged in', testConfig.timeouts.response


    it 'should know about another users are logged before or after own login()', ->
        viewModel = new UserNotificationViewModel
        pusherMock = new PusherMock
        anotherPusherMock = new PusherMock
        userNotification = new UserNotification viewModel, pusherMock
        anotherUserNotification = new UserNotification viewModel, anotherPusherMock
        user = id: 1, info: email: "abc@gmail.com"
        anotherUser = id: 2, info: email: "def@gmail.com"

        runs ->
            userNotification.login()
            pusherMock.send "pusher:subscription_succeeded", me: user, _members_map: createMemberMap [user]

        waitsFor ->
            userNotification.me?
        , 'first user logged in while another didnt yet', testConfig.timeouts.response

        runs ->
            anotherUserNotification.login()
            anotherPusherMock.send "pusher:subscription_succeeded", me: anotherUser, _members_map: createMemberMap [user, anotherUser]
            pusherMock.send "pusher:member_added", anotherUser

        waitsFor ->
            anotherUserNotification.me?
        , 'another user logged in after the first did', testConfig.timeouts.response

        runs ->
            expect(userNotification.connectedUsersCount).toBe 2
            expect(anotherUserNotification.connectedUsersCount).toBe 2


    it 'should update connected users list on member_removed', ->
        viewModel = new UserNotificationViewModel
        pusherMock = new PusherMock
        userNotification = new UserNotification viewModel, pusherMock
        user = id: 1, info: email: "abc@gmail.com"
        anotherUser = id: 2, info: email: "def@gmail.com"

        runs ->
            userNotification.login()
            pusherMock.send "pusher:subscription_succeeded", me: user, _members_map: createMemberMap [user]

        waitsFor ->
            userNotification.me?
        , 'user logged in', testConfig.timeouts.response

        runs ->
            pusherMock.send "pusher:member_added", anotherUser

        waitsFor ->
            userNotification.connectedUsersCount is 2
        , 'another user was added', testConfig.timeouts.response

        runs ->
            pusherMock.send 'pusher:member_removed', anotherUser

        waitsFor ->
            userNotification.connectedUsersCount is 1
        , 'another user was removed', testConfig.timeouts.response

