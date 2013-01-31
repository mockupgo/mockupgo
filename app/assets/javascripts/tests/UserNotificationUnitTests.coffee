config = require '../config'
testConfig = require './testConfig'
UserNotification = (require '../UserNotification').UserNotification

describe 'user notification unit tests', ->

    fakeLogIn = (userNotification) -> userNotification.logged = true

    it 'should be logged in after login()', ->
        userNotification = new UserNotification('user1@gmail.com', testConfig.PusherMock)
        runs ->
            userNotification.login()

        waitsFor ->
            userNotification.logged
        , 'user logged in', testConfig.timeouts.response


    it 'should be logged out after logout()', ->
        userNotification = new UserNotification('user1@gmail.com', testConfig.PusherMock)
        fakeLogIn(userNotification)

        runs ->
            userNotification.logout()

        waitsFor ->
            not userNotification.logged
        , 'user logged out', testConfig.timeouts.response


    it 'should get notification when another user calls login()', ->
        userNotification = new UserNotification('user1@gmail.com', testConfig.PusherMock)
        fakeLogIn(userNotification)
        anotherUserNotification = new UserNotification('user2@gmail.com', testConfig.PusherMock)

        runs ->
            anotherUserNotification.login()

        waitsFor ->
            anotherUserNotification.logged
        , 'user logged in', testConfig.timeouts.response

        runs ->
            expect(userNotification.notifications.length).toBe 1

        waitsFor ->
            userNotification.notifications.length is 0
        , 'object deleted from notifications array', config.durations.notification


    it 'should get notification when another user calls logout()', ->
        userNotification = new UserNotification('user1@gmail.com', testConfig.PusherMock)
        fakeLogIn(userNotification)
        anotherUserNotification = new UserNotification('user2@gmail.com', testConfig.PusherMock)
        fakeLogIn(anotherUserNotification)

        runs ->
            anotherUserNotification.logout()

        waitsFor ->
            not anotherUserNotification.logged
        , 'user logged out', testConfig.timeouts.response

        runs ->
            expect(userNotification.notifications.length).toBe 1

        waitsFor ->
            userNotification.notifications.length is 0
        , 'object deleted from notifications array', config.durations.notification

    it 'should get notifications in count of 1/2/1/0 when some user2 logs in, and then almost immediately some user1 logs out', ->
        userNotification = new UserNotification('user@gmail.com', testConfig.PusherMock)
        fakeLogIn(userNotification)
        anotherUser1Notification = new UserNotification('someuser1@gmail.com', testConfig.PusherMock)
        fakeLogIn(anotherUser1Notification)
        anotherUser2Notification = new UserNotification('someuser2@gmail.com', testConfig.PusherMock)

        runs ->
            anotherUser2Notification.login()

            setTimeout ->
                anotherUser1Notification.logout()
            , config.durations.notification/2

        waitsFor ->
            userNotification.notifications.length is 1
        , 'notifications array has 1 object', testConfig.timeouts.response

        waitsFor ->
            userNotification.notifications.length is 2
        , 'notifications array has 2 objects', testConfig.timeouts.response + config.durations.notification/2

        waitsFor ->
            userNotification.notifications.length is 1
        , 'notifications array has 1 object again', testConfig.timeouts.response + config.durations.notification

        waitsFor ->
            userNotification.notifications.length is 0
        , 'notifications array is empty', testConfig.timeouts.response + config.durations.notification*3/2
