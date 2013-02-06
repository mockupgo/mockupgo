config = require '../config'
testConfig = require './testConfig'
UserNotification = (require '../UserNotification').UserNotification
UserNotificationViewModel = (require '../angular/UserNotificationViewModel').UserNotificationViewModel

describe 'user notification unit tests', ->

    fakeLogIn = (userNotification, email) ->
        userNotification.me = email: email
        userNotification.connectedUsersCount = 1

    it 'should be logged in after login()', ->
        viewModel = new UserNotificationViewModel
        userNotification = new UserNotification viewModel, testConfig.PusherMock
        runs ->
            userNotification.login()

        waitsFor ->
            userNotification.me?

        runs ->
            expect(userNotification.connectedUsersCount).toBe 1
        , 'user logged in', testConfig.timeouts.response


    it 'should know about another user calls login()', ->
        viewModel = new UserNotificationViewModel
        userNotification = new UserNotification viewModel, testConfig.PusherMock
        anotherUserNotification = new UserNotification viewModel, testConfig.PusherMock
        fakeLogIn userNotification, 'someuser1@gmail.com'

        runs ->
            expect(userNotification.connectedUsersCount).toBe 1
            anotherUserNotification.login()

        waitsFor ->
            anotherUserNotification.me?
        , 'another user logged in', testConfig.timeouts.response

        runs ->
            expect(userNotification.connectedUsersCount).toBe 2


    it 'should update connected users list on member_removed', ->
        viewModel = new UserNotificationViewModel
        userNotification = new UserNotification viewModel, testConfig.PusherMock
        fakeLogIn userNotification, 'someuser1@gmail.com'

        runs ->
            testConfig.PusherMock.send 'member_removed'

        waitsFor ->
            expect(userNotification.connectedUsersCount).toBe 0
        , 'user logged out', testConfig.timeouts.response

